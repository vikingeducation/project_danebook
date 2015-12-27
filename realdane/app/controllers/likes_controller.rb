class LikesController < ApplicationController
    
    def create
        #@comment = params[:commentable_type].singularize.constantize.comments.build( params[:comment] )
        @post = Post.find(params[:post_id])
        @comment = Comment.find(params[:comment_id]) if params[:comment_id]
        @like = @post.likes.build(:user_id => current_user.id)
        @like = @comment.likes.build(:user_id => current_user.id) if @comment
        if @like.save
            flash[:success] = "liked"
            redirect_to timeline_user_path(current_user)
        else
            flash[:error] = "fail liked"
            redirect_to timeline_user_path(current_user)
        end
            
    end
    
    def destroy
        if params[:comment_id]
            @like = Like.find(params[:comment_id])
        else
            @like = Like.find(params[:post_id])
        end
        if @like.destroy
            flash[:success] = "destroyed"
            redirect_to timeline_user_path(current_user)
        else
            flash[:error] = "fail destroy"
            redirect_to timeline_user_path(current_user)
        end
    end
    
end
