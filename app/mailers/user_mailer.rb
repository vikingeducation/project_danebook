class UserMailer < ApplicationMailer
  default :from => "mailer@danebook.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Face..*cough*...Danebook!')
  end

  def friend_request(mail)
    @user = mail[:user]
    @friend = mail[:friend]
    mail(subject: 'You have a friend request on Danebook',
         to: mail[:user].email)
  end
end
