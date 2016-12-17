class CommentsController < ApplicationController
  
  def create
    @user = Post.find_by_id(params[:post]).author
    post_id = params[:post]
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = post_id
    if @comment.save
      flash[:success] = "Sweet comment bro!"
      redirect_to @user
    else
      flash[:error] = "Oops! Something went wrong. Our apes are researching this problem as we speak."
      redirect_to @user
    end
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    @user = @comment.post.author
    if @comment.destroy
      flash[:success] = "We nuked it dawg! It is gone!"
      redirect_to @user
    else
      flash[:error] = "Oops! Something went wrong. Our apes are researching this problem as we speak."
      redirect_to @user
    end
  end

  private

  def comment_params
    params.require(:comment).permit(
      :body, :author_id, :post_id)
  end

end
