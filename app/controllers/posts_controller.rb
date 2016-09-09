class PostsController < ApplicationController

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "post succesfully updated"
      redirect_to :back
    else
      flash[:notice] = "post not updated, fix your errors"
      redirect_to :back
    end

  end

  def destroy

    @post = Post.find(params[:id])
    @user = @post.author
    if @post.destroy
      flash[:success] = "Your Post has been deleted!"
    else
      flash[:error] = "Error! The Post lives on!"
    end
    redirect_to :back
  end

  def post_params
    params.require(:post).permit( :comments_attributes => [ :body, :commentable_id, :commentable_type, :commenter_id ])
  end

end
