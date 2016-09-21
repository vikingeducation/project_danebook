class PostsController < ApplicationController

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      @comment = @post.comments.build
      flash[:success] = "Posted!"
      respond_to do |format|
        format.js {} 
        format.html { redirect_to current_user }
      end
    else
      flash[:danger] = "Please enter something!"
      respond_to do |format|
        format.js { head :none }
        format.html { redirect_to current_user }
      end
    end
  end

  def destroy
    begin
      if (@post = current_user.posts.find(params[:id])) && @post.destroy
        flash[:success] = "Post deleted!"
        respond_to do |format|
          format.js {} 
          format.html { redirect_to current_user }
        end
      else
        flash[:danger] = "Post could not be deleted!"
        respond_to do |format|
          format.js { head :none } 
          format.html { redirect_to current_user }
        end
      end
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = "Post could not be deleted!"
    end
    
  end

  private

  def post_params
    params.
      require(:post).
      permit(:text)
  end
end
