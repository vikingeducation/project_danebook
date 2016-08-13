class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @user = @post.user
    @comment = Comment.new(:post_id => params[:post_id].to_i, 
                              :user_id => current_user.id,
                              :body => params[:comment][:body])
    if @comment.save!
      redirect_to user_posts_path(@user)
    else
      redirect_to user_posts_path(@user)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
    @user = @post.user
    @comment.destroy
    redirect_to user_posts_path(@user)
  end

end
