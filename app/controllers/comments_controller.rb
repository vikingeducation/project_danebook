class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @user = @post.user
    @comment = Comment.create(:post_id => params[:post_id], 
                              :user_id => current_user.id,
                              :body => params[:body])
    if @comment.save
      redirect_to user_posts_path(@user)
    else
      redirect_to user_posts_path(@user)
    end
  end

end
