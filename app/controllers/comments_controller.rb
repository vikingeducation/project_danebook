class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(whitelisted_params)
    @comment.author = current_user
    if @comment.save 
      flash[:success] = "You commented on #{@post.author.name}'s post."
      redirect_to user_timeline_path(@post.author)
    else
      flash[:error] = @comment.errors.full_messages.join(', ')
      @user = current_user
      @page_owner = @post.author
      render 'posts/show'
    end
  end



  private 

  def whitelisted_params
    params.require(:comment).permit(:id, :body)
  end

end
