class CommentsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    session[:return_to] ||= request.referer

    @commented_on = Post.find(params[:post_id]) if params[:post_id]
    @commented_on = Photo.find(params[:photo_id]) if params[:photo_id]
    @comment = @commented_on.comments.new(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to session.delete(:return_to), notice: 'Comment was successfully created.' }
        format.json { render 'feeds/show', status: :created, location:  session.delete(:return_to) }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    session[:return_to] ||= request.referer

    comment = Comment.find(params[:id])
    authorize comment
    comment.destroy

    respond_to do |format|
      format.html { redirect_to session.delete(:return_to), notice: "Comment '#{truncate(comment.body, length: 25)}' was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id, :photo_id, :user_id)
  end

end
