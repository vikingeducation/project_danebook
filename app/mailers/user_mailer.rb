class UserMailer < ApplicationMailer
  default from: 'danebook@example.com'

  def welcome(user)
    mail to: user.email, subject: 'Welcome to Danebook'
  end

  def notify_like(user,resource)
    @user = user
    @resource = resource
    mail to: user.email, subject: 'Activity on your Timeline'
  end

  def notify_comment(user,resource)
    @user = user
    @resource = resource
    mail to: user.email, subject: 'Activity on your Timeline'
  end

  def recommend_friends(user,other_users)
    @other_users = [User.find(1)]
    @user = user

    # @user = user
    # @other_users = other_users

    # building other users' thumbnail photos
    @other_users.each do |user|
      attachments.inline[user.avatar_file_name] = File.read(user.avatar.path(:thumb))
    end

    mail to: user.email, subject: 'Add some friends!'
  end

  # def activation(user)
  #   @user = user
  #   mail to: user.email, subject: 'Account Activation'
  # end

  # def password_reset(user)
  #   @user = user
  #   mail to: user.email, subject: 'Password Reset'
  # end
end
