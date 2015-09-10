class CommentsController < ApplicationController
  before_action :require_login

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save

    respond_to do |format|
      format.js {render template: 'profiles/comments.js.erb'}
      format.html {redirect_to request.referrer}
    end

  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    @comment.destroy

    respond_to do |format|
      format.js {render template: 'profiles/comments.js.erb'}
      format.html {redirect_to request.referrer}
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end

end
