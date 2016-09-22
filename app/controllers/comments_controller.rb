class CommentsController < ApplicationController

    def create
      commentable = get_commentable

      if commentable
        @comment = commentable.comments.build(comment_params)
        current_user.comments << @comment

        if @comment.save
          User.send_activity_email(@comment.parent_user.id, @comment.id) unless @comment.parent_user == current_user
          # User.delay.send_activity_email(comment.parent_user.id, comment.id) unless comment.parent_user == current_user
          respond_to do |format|
            format.js {} 
            format.html { go_back }
          end
        else
          flash[:danger] = "Could not create comment."
          respond_to do |format|
            format.js { head :none }
            format.html { go_back }
          end
        end
      else
        flash[:danger] = "Could not create comment."
        respond_to do |format|
          format.js { head :none }
          format.html { go_back }
        end
      end
    end

    def destroy
      begin
        @comment = current_user.comments.find(params[:id])
        if @comment.destroy
          respond_to do |format|
            format.js {} 
            format.html { redirect_to URI(request.referer).path }
          end
        else
          flash[:danger] = "Could not delete comment!"
          respond_to do |format|
            format.js { head :none } 
            format.html { redirect_to URI(request.referer).path }
          end
        end
      rescue ActiveRecord::RecordNotFound
        flash[:danger] = "Could not delete comment!"
        redirect_to URI(request.referer).path
      end

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
