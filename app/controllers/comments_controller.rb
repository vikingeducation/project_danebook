class CommentsController < ApplicationController
  include UserCheck

  before_action :set_user
  before_action :get_post
  before_action :correct_user, except: [:show, :new, :create]

  def new
    if @user.friends.include?(current_user)
      @comment = @post.comments.build
    else
      flash[:danger] = ["You can only comment on your friends' posts."]
      redirect_to user_post_path(@user, @post)
    end
  end

  def create
    @comment = @post.comments.build(whitelisted)
    if @comment.save
      flash[:success] = ["Comment Successfull"]
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:danger] = ["Something went wrong.."]
      @comment.errors.full_messages.each do |error|
        flash[:danger] << error
      end
      redirect_to user_post_path(@user, @post)
    end
  end


  private
    def get_post
      @post = Post.includes(:comments).find_by_id(params[:post_id])
      unless @post
        flash[:danger] = ["Post does not exist"]
        redirect_to root_path
      end
    end

    def whitelisted
      params.require(:post).permit(:body).merge(post_type: "Comment", user_id: current_user.id)
    end
end
