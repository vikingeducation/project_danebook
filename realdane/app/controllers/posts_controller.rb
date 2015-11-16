class PostsController < ApplicationController
    
    def create
        @post = current_user.posts.build(post_params)
        #@post.id = @post.user.id
        if @post.save
            flash[:success] = "post posted"
            redirect_to timeline_user_path(current_user)
        else
            flash[:success] = "post not posted"
            redirect_to timeline_user_path(current_user)
        end
    end
    
    
private
    def post_params
        params.
        require(:post).
        permit(
            :words,
            #:user_id
            )
    end
end
