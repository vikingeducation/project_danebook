class NotificationMailer < ApplicationMailer
  def comment(comment)
    @comment = comment
    mail(
      :to => @comment.commentable.user.email,
      :subject => subject("#{@comment.user.name} commented on your #{@comment.commentable.class.name.downcase}")
    )
  end

  def friend_request(friend_request)
    @friend_request = friend_request
    mail(
      :to => @friend_request.approver.email,
      :subject => subject("You've just received a new friend request from #{@friend_request.initiator.name}")
    )
  end

  def friendship(friendship)
    @friendship = friendship
    mail(
      :to => @friendship.initiator.email,
      :subject => subject("#{@friendship.approver.name} has accepted your friend request")
    )
  end

  def like(like)
    @like = like
    mail(
      :to => @like.likeable.user.email,
      :subject => subject("#{@like.user.name} has liked your #{@like.likeable.class.name.downcase}")
    )
  end
end
