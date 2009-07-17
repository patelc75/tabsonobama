class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
  
  before_filter :login_required, :only => [ :index, :edit, :update ]
  
  def index
    @roles = Role.all
    @users = User.all
  end
  
  def edit
    @roles = Role.all
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user roles."
      respond_to do |format|
        format.html { redirect_to users_url }
        format.js { render :partial => "/users/pop_signup_form" }
      end
    else
      render :action => 'edit'
    end
  end
  
  def new
    @user = User.new(:invitation_token => params[:invitation_token])
    @user.email = @user.invitation.recipient_email.strip if @user.invitation
    @profile = @user.build_profile
  end
  
  def create
    logout_keeping_session!
    if using_open_id?
      authenticate_with_open_id(params[:openid_url], :return_to => open_id_create_url, 
        :required => [:nickname, :email]) do |result, identity_url, registration|
        if result.successful?
          create_new_user(:identity_url => identity_url, :login => registration['nickname'], :email => registration['email'])
        else
          failed_creation(result.message || "Sorry, something went wrong")
        end
      end
    else
      # $stderr.puts "\n DEBUG DEBUG DEBUG \n #{params[:user]} \n DEBUG DEBUG DEBUG \n"
      create_new_user(params[:user])
    end
  end
  
  def activate
    logout_keeping_session!
    #logout_killing_session
    @user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && @user && !@user.active?
      @user.activate!
    
      #flash[:notice] = "Signup complete! Please sign in to continue."
      respond_to do |format|
        #format.html { redirect_to login_path }
        format.html { redirect_to "http://staging.tabsonobama.org/home"}
        #format.html {redirect_to : action=> "/home"}
       # format.html { render :controller => :users, :action => :success_activate }
        #format.js { render :partial => "/users/pop_signup_form" }
        format.js { render :partial => "/users/nav_login_form" }
      end
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      respond_to do |format|
        format.html { redirect_to login_path }
      	#format.html { redirect_back_or_default(root_path) }
        format.js { render :partial => "/users/pop_signup_form" }
      end
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      respond_to do |format|
        format.html { redirect_to login_path }
      	#format.html { redirect_back_or_default(root_path) }
        format.js { render :partial => "/users/pop_signup_form" }
      end
    end
  end
  
  protected
  
  def create_new_user(attributes)
    @user = User.new(attributes)
    RAILS_DEFAULT_LOGGER.info "@user.login: #{@user.login} enter User.create_new_user"
    if @user.valid?
      RAILS_DEFAULT_LOGGER.info "@user.login #{@user.login} passed @user.valid?"
      if @user.not_using_openid?
		RAILS_DEFAULT_LOGGER.info "@user.login #{@user.login} passed @user.not_using_openid?"
		#RAILS_DEFAULT_LOGGER.info "#{params[:recaptcha_challenge_field} #{params[:recaptcha_response_field]}"
          @user.register! if validate_recap(params, @user.errors)
      else
        @user.register_openid!
      end
    end
	
    if @user.errors.empty?
      successful_creation(@user)
    else
      respond_to do |format|
      	format.html { render :controller => :users, :action => :new }
        format.js { render :partial => "/users/pop_signup_form", :locals => { :status => 'failure', :user => @user, :display => 'block' } }
      end
      #failed_creation
    end
  end
  
  def successful_creation(user)
    flash[:notice] = "Thanks for signing up!"
    flash[:notice] << " We're sending you an email with your activation code." if @user.not_using_openid?
    flash[:notice] << " You can now login with your OpenID." unless @user.not_using_openid?
    
    respond_to do |format|
      #format.html { redirect_back_or_default(root_path) }
      format.html { render :controller => :users, :action => :success }
      format.js { render :partial => "/users/pop_signup_form", :locals => { :status => 'success', :logintype => 'normal', :display => 'block' } } if @user.not_using_openid?
      format.js { render :partial => "/users/pop_signup_form", :locals => { :status => 'success', :logintype => 'openid', :display => 'block' } } unless @user.not_using_openid?
    end
  end
  
  def failed_creation(message = 'Sorry, there was an error creating your account')
    flash[:error] = message
    respond_to do |format|
      format.html { render :controller => :users, :action => :new }
      format.js { render :partial => "/users/pop_signup_form" }
    end
  end
  
  def authorized?
    logged_in? && current_user.is_super_admin?
  end
  
end
