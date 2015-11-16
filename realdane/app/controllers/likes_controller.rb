class LikesController < ApplicationController
    
    def create
        @post = Post.find(params[:post_id])
        @like = @post.likes.build(:user_id => current_user.id)
        if @like.save
            flash[:success] = "liked"
            redirect_to timeline_user_path(current_user)
        else
            flash[:error] = "fail liked"
            redirect_to timeline_user_path(current_user)
        end
            
    end
    
    def destroy
       @like = Like.find(params[:id])
        if @like.destroy
            flash[:success] = "destroyed"
            redirect_to timeline_user_path(current_user)
        else
            flash[:error] = "fail destroy"
            redirect_to timeline_user_path(current_user)
        end
    end
    
end
