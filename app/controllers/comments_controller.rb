class CommentsController < ApplicationController

	before_action :require_login

	def create
		@comment = Comment.new(whitelisted_comment_params)
		@comment.user_id = params[:user_id]

		respond_to do |format|

			if @comment.save
				flash[:success] = "Commented"
				format.html {redirect_to URI(request.referer).path}
				format.js {render :create}
			else
				flash[:error] = "Unable to comment"
				format.html {redirect_to URI(request.referer).path}
				format.js {redirect_to URI(request.referer).path}
			end

		end


	end

	def update
	end

	def destroy
		@comment = Comment.find(params[:id])

		respond_to do |format|

			if @comment.destroy
				flash[:success] = "Deleted your comment"
				format.html {redirect_to URI(request.referer).path}
				format.js {render :destroy}
			else
				flash[:error] = "Could not delete comment"
				format.html {redirect_to URI(request.referer).path}
				format.js {redirect_to URI(request.referer).path}
			end

		end

	end

	private

	def whitelisted_comment_params
		params.require(:comment).permit(:user_id,
																		:body,
																		:commentable_type,
																		:commentable_id)
	end

end
