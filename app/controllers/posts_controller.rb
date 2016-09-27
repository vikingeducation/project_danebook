class PostsController < ApplicationController

  def create
    @post = current_user.posts.build(white_list_params)
    if @post.save
      flash[:success] = "Post is created successfully"
      respond_to do |format|
        format.html { redirect_back(fallback_location: fallback_location) }
        format.js { render :create_post }
      end
    else
      flash[:danger] = "Sorry, post is not created"
      redirect_back(fallback_location: fallback_location)
    end
  end

  def destroy
    post = Post.find_by_id(params[:id])
    if post && post.destroy
      flash[:success] = "Post has been deleted"
    else
      flash[:danger] = "Post can not be deleted"
    end
    redirect_back(fallback_location: fallback_location)
  end

  private
    def white_list_params
      params.require(:post).permit(:body)
    end
end
