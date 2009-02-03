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
      #redirect_to users_url
	  respond_to do |format|
		  format.js { render :partial => "/users/pop_signup_form" }
	  end
    else
      render :action => 'edit'
    end
  end
  
  def new
    @user = User.new
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
	  $stderr.puts "\n DEBUG DEBUG DEBUG \n #{params[:user]} \n DEBUG DEBUG DEBUG \n"
	  create_new_user(params[:user])
    end
  end
  
  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      #redirect_to login_path
	  respond_to do |format|
		  format.js { render :partial => "/users/pop_signup_form" }
	  end
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      #redirect_back_or_default(root_path)
	  respond_to do |format|
		  format.js { render :partial => "/users/pop_signup_form" }
	  end
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      #redirect_back_or_default(root_path)
	  respond_to do |format|
		  format.js { render :partial => "/users/pop_signup_form" }
	  end
    end
  end
  
  protected
  
  def create_new_user(attributes)
    @user = User.new(attributes)
    if @user.valid?
      if @user.not_using_openid?
        if validate_recap(params, @user.errors)
          @user.register!
        end
      else
        @user.register_openid!
      end
    end
    
    if @user.errors.empty?
      successful_creation(@user)
    else
	  respond_to do |format|
		format.js { render :partial => "/users/pop_signup_form", :locals => { :status => 'failure', :user => @user, :display => 'block' } }
	  end
      #failed_creation
    end
  end
  
  def successful_creation(user)
    #redirect_back_or_default(root_path)
	  respond_to do |format|
		  format.js { render :partial => "/users/pop_signup_form", :locals => { :status => 'success', :logintype => 'normal', :display => 'block' } } if @user.not_using_openid?
		  format.js { render :partial => "/users/pop_signup_form", :locals => { :status => 'success', :logintype => 'openid', :display => 'block' } } unless @user.not_using_openid?
	  end
    flash[:notice] = "Thanks for signing up!"
    flash[:notice] << " We're sending you an email with your activation code." if @user.not_using_openid?
    flash[:notice] << " You can now login with your OpenID." unless @user.not_using_openid?
  end
  
  def failed_creation(message = 'Sorry, there was an error creating your account')
    flash[:error] = message
    #render :action => :new
	respond_to do |format|
		format.js { render :partial => "/users/pop_signup_form" }
	end
  end
  
  def authorized?
    logged_in? && super_admin?
  end
  
  def super_admin?
    super_admin_role = Role.find_by_name('super_admin')
    current_user.roles.include?(super_admin_role)
  end
end
