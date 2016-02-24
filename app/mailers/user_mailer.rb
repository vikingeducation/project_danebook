class UserMailer < ApplicationMailer
  default :from => "from@example.com"
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Danebook!')
  end

  def notify(receiver, commenter, resource)
    @user = receiver
    @commenter = commenter
    @resource = resource

    if @resource.is_a?(Post)
      @link = user_timeline_url(@user)
    else
      @link = photo_url(@photo)
    end

    mail(to: @user.email, subject: 'New notification')
  end

end
