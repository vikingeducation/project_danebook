class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :likeable_set_up, only: [:create, :destroy]

  def create
    @like = current_user.likes.build(likeable_id: @id, likeable_type: params[:likeable])
    if @like.save
      respond_to do |format|
        format.html do
          flash[:success] = "Post liked"
          redirect_to :back
        end
        format.js { set_render_template }
      end
    else
      flash[:error] = "You've already liked that post"
    end
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, likeable_id: @id, likeable_type: params[:likeable])
    if @like.destroy
      respond_to do |format|
        format.html do
          flash[:success] = "Post unliked"
          redirect_to :back
        end
        format.js { set_render_template}
      end
    else
      flash[:error] = "Couldn't unlike"
    end
    # redirect_to :back
  end

  private

  def set_render_template
    case params[:likeable]
    when 'Post'
      render :update_post
    when 'Photo'
      render :update_photo
    when 'Comment'
      render :update_comment
    end
  end

  def likeable_set_up
    if params[:likeable] == 'Post'
      @id = params[:post_id]
      @poster = Post.find(@id).user
      @post = Post.find(@id)
    elsif params[:likeable] == 'Photo'
      @id = params[:photo_id]
      @post = Photo.find(@id)
    elsif params[:likeable] == 'Comment'
      @id = params[:comment_id]
      @comment = Comment.find(@id)
    end
  end

end
