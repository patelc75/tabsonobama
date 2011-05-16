class InvitationMailer < ActionMailer::Base
  
  def invitation(invitation, signup_link)
    setup_email(invitation, signup_link)
    invitation.update_attribute(:sent_at, Time.now)
  end

private

  def setup_email(invitation, signup_link)
    subject    "[#{APP_CONFIG[:site_name]}] Invitation"
    recipients invitation.recipient_email
    #from       APP_CONFIG[:admin_email]
    from 	   "no-reply@tabsonrahm.org"
    sent_on    Time.now
    body       :invitation => invitation, :signup_link => signup_link
  end

end
