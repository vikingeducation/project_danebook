class CommentsController < ApplicationController

	before_action :require_login

	def create
		@comment = Comment.new(whitelisted_comment_params)
		@comment.user_id = params[:user_id]
		if @comment.save
			flash[:success] = "Commented"
		else
			flash[:error] = "Unable to comment"
		end
		redirect_to URI(request.referer).path
	end

	def update
	end

	def destroy
		@comment = Comment.find(params[:id])
		if @comment.destroy
			flash[:success] = "Deleted your comment"
		else
			flash[:error] = "Could not delete comment"
		end
		redirect_to URI(request.referer).path
	end

	private

	def whitelisted_comment_params
		params.require(:comment).permit(:user_id, 
																		:body,
																		:commentable_type,
																		:commentable_id)
	end

end
