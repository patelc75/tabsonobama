require "smtp_tls"

gmail_configs = File.open("#{RAILS_ROOT}/config/gmail.yml")
SMTP_SETTINGS_GMAIL = YAML.load(gmail_configs)

SMTP_SETTINGS_LOCALHOST = {
  :address => "localhost" ,
  :port => 25,
  :domain => "tabsonobama.org",
  :authentication => :login,
  :user_name => "tabsuser",
  :password => "r0ck0n"
}

case ENV['RAILS_ENV']
when 'production'
  ActionMailer::Base.smtp_settings = SMTP_SETTINGS_LOCALHOST
when 'staging'
  ActionMailer::Base.smtp_settings = SMTP_SETTINGS_LOCALHOST
else
  ActionMailer::Base.smtp_settings = SMTP_SETTINGS_GMAIL
end
