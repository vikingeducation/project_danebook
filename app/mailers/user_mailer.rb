class UserMailer < ApplicationMailer
  default :from => "no_reply@ajk-danebook.herokuapp.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Danebook!")
  end

  def notify(comment)
    @user = comment.commentable.poster
    @commenter_name = comment.author.profile.full_name
    @commentable_type = comment.commentable_type.downcase
    @link = notify_link(comment.commentable)
    mail(to: @user.email, subject: "#{@commenter_name} commented on your #{@commentable_type}!")
  end


  private

    def notify_link(commentable)
      case commentable.class.to_s
      when 'Post'
        then user_posts_url(commentable.poster)
      when 'Photo'
        then user_photo_url(commentable.poster, commentable)
      end
    end

end
