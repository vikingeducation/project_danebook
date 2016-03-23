class CommentsController < ApplicationController
  before_action :require_login
  before_action :require_current_user, :only => [:destroy]

  def create
    
    @comment = Comment.new(comment_params)
    
    if @comment.save
      flash[:success] = "Comment saved!"

      puts "!!!!!! Param Post Id is #{params["comment"]["commentable_id"]}"

      @post = Post.find((params["comment"]["commentable_id"]))

      respond_to do |format|

        format.html {redirect_user_path(params["comment"][:user_id])}
        format.js {render :create_comment}

      end  

    else
      flash[:alert] = "Comment not saved!"
      redirect_user_path(params["comment"][:user_id])
    end
  end 

  def destroy
    @comment_id = params[:id]
    @comment = Comment.find(@comment_id)
    if @comment.destroy
      flash[:success] = "Comment deleted!"

      respond_to do |format|
        format.html {redirect_to new_user_post_path(params[:user_id])}
        format.js {render :delete_comment}
      end  
    else
      flash[:alert] = "Comment not deleted!"
      redirect_to new_user_post_path(params[:user_id])
    end
 end

  private

  def redirect_user_path(user_id)
    if user_id == current_user.id.to_s
       redirect_to new_user_post_path(user_id)
    else
       redirect_to user_posts_path(user_id)
    end 
  end
    
  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type, :user_id)
  end
end