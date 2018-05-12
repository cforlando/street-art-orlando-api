class ApplicationMailer < ActionMailer::Base
  default from: ENV['AWS_SES_SMTP_DEFAULT_EMAIL']
  layout 'mailer'
end
