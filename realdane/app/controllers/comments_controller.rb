class CommentsController < ApplicationController
    
    def create
        @comment = current_user.comments.build(comment_params)
        @comment.post_id = params[:post_id]
        if @comment.save
            flash[:success] = "post posted"
            redirect_to timeline_user_path(current_user)
        else
            flash[:error] = "post not posted"
            redirect_to timeline_user_path(current_user)
        end
    end
    
private
    def comment_params
        params.
        require(:comment).
        permit(
            :words,
            :post_id
            )
    end
    
end
