class CommentsController < ApplicationController
  include ActionView::Helpers::TextHelper


  def create
    session[:return_to] ||= request.referer

    commented_on = set_commented_on
    comment = commented_on.comments.new(comment_params)
    comment.user_id = current_user.id

    if comment.save
      comment_recipient = commented_on.user
      comment_recipient.send_comment_notification(commented_on, comment) unless comment_recipient == current_user
      redirect_to session.delete(:return_to), notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def destroy
    session[:return_to] ||= request.referer

    comment = Comment.find(params[:id])
    authorize comment
    comment.destroy

    redirect_to session.delete(:return_to), notice: "Comment '#{truncate(comment.body, length: 25)}' was successfully destroyed."
  end

  private

  def set_commented_on
    post_id = params[:post_id]
    photo_id = params[:photo_id]

    Post.find(post_id) if post_id
    Photo.find(photo_id) if photo_id
  end

  def comment_params
    params.require(:comment).permit(:body, :post_id, :photo_id, :user_id)
  end

end
