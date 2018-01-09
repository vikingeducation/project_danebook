class CommentsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_timeline_path(@post.user), notice: 'Comment was successfully created.' }
        format.json { render 'users/timeline', status: :created, location: user_timeline_path(@post.user) }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    timeline_user = comment.commentable.user

    authorize comment
    comment.destroy

    respond_to do |format|
      format.html { redirect_to user_timeline_path(timeline_user), notice: "Comment '#{truncate(comment.body, length: 25)}' was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id, :user_id)
  end

end
