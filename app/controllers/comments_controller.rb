class CommentsController < ApplicationController

    def create
      commentable = get_commentable

      if commentable
        comment = commentable.comments.build(comment_params)
        comment.commenter_id = current_user.id

        unless comment.save
          flash[:danger] = "Could not create comment."
        end
      else
        flash[:danger] = "Could not create comment."
      end

      redirect_to URI(request.referer).path
    end

    def destroy
      comment = current_user.comments.find(params[:id])

      unless comment.destroy
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
      end
    end
end
