class UserMailer < ApplicationMailer

  default from: "admin@danebook.com"

  def welcome(user)
    @user = user
    @profile = @user.profile

    mail(to: @user.email , subject: "Welcome to Danebook #{@profile.first_name}!")

  end

  def comment_notification(comment_id)
    @comment = Comment.find(comment_id)
    @user = @comment.user
    @to_user = @comment.commentable.user 

    mail(to: @to_user.email , subject: "Comment Notification by #{@user.username}")
    
  end


  def friend_suggestion(user_id)
    
    @user = User.find(user_id)
    
    friends = @user.friends
    users = User.all

    @friends_array = []
    
    make_friends = users - friends_array - [@user]

    if make_friends.size  < 3
       @friends_array = make_friends
    else      
      3.times do |num|
        new_friend = [make_friends - @friends_array].sample
        @friends_array = new_friend
      end  
    end
    
    mail(to: @user.email , subject: "#{@user.username} - make new friends")
    
  end

end