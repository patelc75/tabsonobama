class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
  
  def new
  end

  def create
    logout_keeping_session!
    if using_open_id?
      open_id_authentication
    else
      password_authentication
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(root_path)
  end
  
  def open_id_authentication
    authenticate_with_open_id do |result, identity_url|
      if result.successful? && self.current_user = User.find_by_identity_url(identity_url)
        successful_login
      else
        flash[:error] = result.message || "Sorry no user with that identity URL exists"
        @remember_me = params[:remember_me]
        render :action => :new
      end
    end
  end

  protected
  
  def password_authentication
    user = User.authenticate(params[:login], params[:password])
    if user
      self.current_user = user
      successful_login
    else
      @login = params[:login]
      @remember_me = params[:remember_me]
      note_failed_signin
    end
  end
  
    
  def successful_login
    new_cookie_flag = (params[:remember_me] == "1")
    handle_remember_cookie! new_cookie_flag
    flash[:notice] = "Logged in successfully"
    respond_to do |format|
      #format.html { redirect_back_or_default(root_path) }
      #format.js { render :partial => "/users/pop_login_form" }
      format.html { redirect_to "http://staging.tabsonobama.org/home/"}
      format.js { render :partial => "/users/nav_login_form" }
    end
  end

  def note_failed_signin
    flash.now[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
    respond_to do |format|
      format.html { render :action => :new }
      #format.js { render :partial => "/users/pop_login_form" }
      format.js { render :partial => "/users/nav_login_form" }
    end
  end
end
