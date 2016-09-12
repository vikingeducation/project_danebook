class LikesController < ApplicationController
  def create
    if params[:likable_type] == "Comment"
      @comment = Comment.find(params[:comment_id])
      @like = @comment.likes.build
      @like.user = current_user
      redirect_to user_timeline_path(@comment.author)
    elsif params[:likable_type] == "Photo"
      @photo = Photo.find(params[:photo_id])
      @like = @photo.likes.build
      @like.user = current_user
      redirect_to user_photo_path(@photo.owner, @photo)
    else
      @post = Post.find(params[:post_id])
      @like = @post.likes.build
      @like.user = current_user
      redirect_to user_timeline_path(@post.author)
    end

    if @like.save
      flash[:success] = "Cool, you liked it."
    else
      flash[:error] = @like.errors.full_messages.join(", ")
    end

  end

  def destroy
    @like = Like.find(params[:id])
    if @like && @like.destroy
      flash[:success] = "You unliker, you..."
      redirect_to :back
    else
      flash[:error] = "Let us do the liking, mister. (Your unlike wasn't recorded.)"
      redirect_to :back
    end    
  end


end
