class UserMailer < ApplicationMailer
  default from: "welcome@danebook.com"

  def welcome(user)
    @user = user
    @suggested_friends = User.limit(6)
    # 6.times { @suggested_friends << User.pluck.sample }
    mail(to: @user.email, subject: "Welcome to Danebook")
  end

end
