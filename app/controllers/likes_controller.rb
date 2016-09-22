class LikesController < ApplicationController

  def create

    likable = get_likable
    @parent_type = params[:likable]

    if likable
    # TODO: check to see if it's already liked
    # unless Like.find_by(user_id: current_user.id, likable_id: 11)
      @like = likable.likes.build
      current_user.likes << @like

      if @like.save
        respond_to do |format|
          format.js {} 
          format.html { go_back }
        end
      else
        flash[:danger] = "Could not be liked."
        respond_to do |format|
          format.js { head :none } 
          format.html { go_back }
        end
      end
    else
      flash[:danger] = "Could not be liked."
      respond_to do |format|
        format.js { head :none } 
        format.html { go_back }
      end
    end

  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @parent_type = @like.likable_type
    puts "*****" + @parent_type

    if @like.destroy
      @comment = current_user.comments.build
      respond_to do |format|
        format.js {} 
        format.html { go_back }
      end
    else
      flash[:danger] = "Could not be unliked!"
      respond_to do |format|
        format.js {} 
        format.html { go_back }
      end
    end

  end

  private

  def get_likable
    if params[:likable] == 'Post'
      return Post.find(params[:post_id])
    elsif params[:likable] == 'Comment'
      return Comment.find(params[:comment_id])
    elsif params[:likable] == 'Photo'
      return Photo.find(params[:photo_id])
    end
  end

end
