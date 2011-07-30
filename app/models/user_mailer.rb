class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject << 'Please activate your new account'
    @body[:url] = "#{APP_CONFIG[:site_url]}/activate/#{user.activation_code}"
    @body[:site_name] = APP_CONFIG[:site_name]
  end
  
  def activation(user)
    setup_email(user)
    @subject << 'Your account has been activated!'
    @body[:url] = APP_CONFIG[:site_url]
  end

  def test_email(to, subject, body) 
    setup_message(subject, body)
    @recipients = []
    @recipients  << to
  end

  protected

  def setup_message(subject, msg_body)
    @from        = "no-reply@tabsonrahm.org"
    @subject     = "[" + `hostname` + "] "
    @subject     += subject unless subject.blank?
    @sent_on     = Time.now
    body msg_body
  end
  
  
  def setup_email(user)
    @recipients = "#{user.email}"
    #@from = APP_CONFIG[:admin_email]
    @from = "no-reply@tabsonrahm.org"
    @subject = "[#{APP_CONFIG[:site_name]}] "
    @sent_on = Time.now
    @body[:user] = user
  end
end
