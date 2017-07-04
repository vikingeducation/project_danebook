class ApplicationMailer < ActionMailer::Base
  default from: 'from@localhost.com'
  layout 'mailer'

  add_template_helper(EmailHelper)
end
