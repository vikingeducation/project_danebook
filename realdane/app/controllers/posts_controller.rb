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
    

    
    def update
        @post = Post.find_by(params[:id])
        if @post.update_attributes(post_params)
            flash[:success] = "post updated"
            redirect_to timeline_user_path(current_user)
        else
            flash[:errors] = "post not updated"
            redirect_to timeline_user_path(current_user)
        end
        
    end
    
    def create_comment
        @comment = current_user.comments.build(
            :words => params[:post][:comments_attributes]["0"]["words"],
            :post_id => params[:id]
            )
        if @comment.save
            flash[:success] = "post updated"
            redirect_to timeline_user_path(current_user)
        else
            flash[:errors] = "post not updated"
            redirect_to timeline_user_path(current_user)
        end
    end
    
    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        if @post.destroy
            flash[:success] = "deleted"    
            redirect_to timeline_user_path(current_user)
        else
            flash[:errors] = "not deleted"
            redirect_to timeline_user_path(current_user)
        end
        
    end
    
    
private
    def post_params
        params.
        require(:post).
        permit(
            :words,
            :user_id
            )
    end
    
    def advanced_post_params
        params.
        require(:post).
        permit(
            :words,
            :user_id,
            :comments_attributes =>
            [
                :words,
                :post_id
                ]
            )
    end
end
