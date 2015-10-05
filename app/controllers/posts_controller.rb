class PostsController < ApplicationController

	before_action :require_login
	before_action :require_object_owner, only: [:destroy]

def index
	@posts = Post.where(:user_id => params[:user_id]).reverse
	@new_post = Post.new
	@new_comment = Comment.new
end

def create
	@post = Post.new(whitelist_post_params)
	@post.user_id = current_user.id
	@new_comment = Comment.new # Sent in from format.js to render new comment partial from post show

	respond_to do |format|

		if @post.save
			flash[:success] = "Post created"
			format.html {redirect_to user_timeline_path}
			format.js
		else
			flash[:error] = "Unable to save post"
			format.html {redirect_to user_timeline_path}
			format.js {redirect_to user_timeline_path}
		end

	end

end

def destroy
	@post = Post.find(params[:id])

	respond_to do |format|

	if @post.destroy
		flash[:success] = "Post deleted"
		format.html {redirect_to user_timeline_path}
		format.js
	else
		flash[:error] = "Post not deleted"
		format.html {redirect_to user_timeline_path}
		format.js {redirect_to user_timeline_path}
	end


	end

end

private

def whitelist_post_params
	params.require(:post).permit(:body)
end

end
