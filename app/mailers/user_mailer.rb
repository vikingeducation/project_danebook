class UserMailer < ActionMailer::Base
  default from: "richardson.ae@gmail.com"
  layout 'mailer' # tells the class to use the generic mailer layout

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My App!')
  end
end
