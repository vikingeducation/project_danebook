class CommentsController < ApplicationController
    
    def create
        @comment = current_user.comments.build(comment_params)
        if @comment.save
            flash[:success] = "post posted"
            redirect_to timeline_user_path(current_user)
        else
            flash[:success] = "post not posted"
            redirect_to timeline_user_path(current_user)
        end
    end
    
private
    def comment_params
        params.
        require(:comment).
        permit(
            :words,
            #:user_id,
            :post_id
            )
    end
    
end
