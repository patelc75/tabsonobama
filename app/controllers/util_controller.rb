class UtilController < ApplicationController
  #before_filter :login_required, :only => [:index]
  require_role "admin"
  
  def info
  end

  def send_test_email      
  end    
  
  def deliver_test_email    
    email = UserMailer.deliver_test_email(params[:to], params[:subject], params[:body])  
  end
end
