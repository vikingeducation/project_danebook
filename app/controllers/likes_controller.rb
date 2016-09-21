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
      if @like.save 
        respond_to do |format|
          format.html { redirect_to user_timeline_path(@post.author) }
          format.js {}
        end
      else 
        format.html { flash.now[:error] = "There was an error" }
      end
      
    end

  end

  def destroy
    @like = Like.find(params[:id])
    respond_to do |format|
      format.html { redirect_to :back }
      format.js do 
        if @like.destroy
          flash.now[:success] = "You unliker, you..."
        else
          flash.now[:error] = "Let us do the liking, mister. (Your unlike wasn't recorded.)"
        end    
      end
    end
      
  end


end
