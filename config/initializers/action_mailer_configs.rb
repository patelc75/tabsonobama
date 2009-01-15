require "smtp_tls"

if (ENV['RAILS_ENV'] == 'production')
  ActionMailer::Base.smtp_settings = {
    :address => "localhost" ,
    :port => 25,
    :domain => "tabsonobama.org"
  }
else
  mailer_config = File.open("#{RAILS_ROOT}/config/gmail.yml")
  mailer_options = YAML.load(mailer_config)
  ActionMailer::Base.smtp_settings = mailer_options
end