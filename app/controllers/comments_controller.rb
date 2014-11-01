class CommentsController < ApplicationController

	before_action :require_signed_in


	def create
		@comment = hack_commentable.comments.build(comment_params)
    if @comment.save
      redirect_to request.referrer
    else
      flash[:error] = "There was a terrible problem with that comment"
    end
	end

	def edit
	end

	def update
	end

  def destroy
    @comment = Comment.find(params[:id])
    @user = @comment.commentable.user

    if @comment.destroy
      flash[:success] = "Deleted."
    else
      flash[:error] = "Something went wrong with that deletion."
    end

    redirect_to request.referrer
  end

  private

  def hack_commentable
  	commentable_class.find(params[parent_id])
  end

  def commentable_class
  	params[:commentable].singularize.classify.constantize
  end

  def comment_params
    params.require(:comment).permit(:body, user_id: :author_id)
  end

  # thanks Andur!
  def parent_id
    "#{params[:commentable].to_s}_id".downcase.to_sym
  end

end
