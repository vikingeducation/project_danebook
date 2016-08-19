class UserMailer < ApplicationMailer
  default from: "welcome@danebook.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Danebook!')
  end

  def commented_by(commenter, to_user, object)
    @user = to_user
    @commenter = commenter
    @object = object
    mail(to: @user.email, subject: "#{@commenter.first_name} just commented on a #{@object.class.to_s.downcase} of yours!")
  end

  def liked_by(liker, to_user, object)
    @user = to_user
    @liker = liker
    @object = object
    mail(to: @user.email, subject: "#{@liker.first_name} just liked a #{@object.class.to_s.downcase} of yours!")
  end

  def posted_by(poster, to_user, object)
    @user = to_user
    @poster = poster
    mail(to: @user.email, subject: "#{@poster.first_name} just posted on your wall!")
  end
end
