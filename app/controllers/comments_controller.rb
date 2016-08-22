class CommentsController < ApplicationController

    def create
      commentable = get_commentable

      if commentable
        comment = commentable.comments.build(comment_params)
        current_user.comments << comment

        if comment.save
          User.delay.send_activity_email(comment.parent_user.id, comment.id) unless comment.parent_user == current_user
        else
          flash[:danger] = "Could not create comment."
        end
      else
        flash[:danger] = "Could not create comment."
      end

      if request.referer
        redirect_to URI(request.referer).path
      else
        redirect_to root_path
      end
    end

    def destroy
      begin
        comment = current_user.comments.find(params[:id])
        unless comment.destroy
          flash[:danger] = "Could not delete comment!"
        end
      rescue ActiveRecord::RecordNotFound
        flash[:danger] = "Could not delete comment!"
      end

      redirect_to URI(request.referer).path
    end

    private

    def comment_params
      params.require(:comment).permit(:text)
    end

    def get_commentable
      if params[:commentable] == 'Post'
        return Post.find(params[:post_id])
      elsif params[:commentable] == 'Comment'
        return Comment.find(params[:comment_id])
      elsif params[:commentable] == 'Photo'
        return Photo.find(params[:photo_id])
      end
    end
end
