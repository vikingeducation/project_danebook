class CommentsController < ApplicationController
  include UserCheck

  before_action :set_user
  before_action :get_post
  before_action :correct_user, except: [:show]

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(user_id: current_user.id, body: params[:post][:body], post_type: "Comment")
    if @comment.save
      flash[:success] = ["Comment Successfull"]
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:danger] = ["Something went wrong.."]
      @comment.errors.full_messages.each do |error|
        flash.now[:danger] << error
      end
      render :new
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
end
