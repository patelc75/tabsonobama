gem 'recaptcha'

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include RoleRequirementSystem
  include ReCaptcha::AppHelper
  
  helper :all # include all helpers, all the time
  protect_from_forgery :secret => 'b0a876313f3f9195e9bd01473bc5cd06'
  filter_parameter_logging :password, :password_confirmation
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  before_filter :build_user_and_profile
  
  protected
  
  # Automatically respond with 404 for ActiveRecord::RecordNotFound
  def record_not_found
    render :file => File.join(RAILS_ROOT, 'public', '404.html'), :status => 404
  end
  
  def build_user_and_profile
    @user = User.new
    @profile = @user.build_profile
  end
end

