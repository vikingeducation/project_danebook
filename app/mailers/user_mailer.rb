class UserMailer < ActionMailer::Base
  default from: "richardson.ae@gmail.com"
  layout 'mailer' # tells the class to use the generic mailer layout

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My App!')
  end

  def comment_notification(comment_recipient, commented_object, comment)
    @user = comment_recipient
    @activity_name = commented_object.class.to_s.downcase
    @comment = comment
    mail(to: @user.email, subject: "#{@comment.user.name} commented on your #{@activity_name}!")
  end
end
