class CommentsController < ApplicationController

	before_action :require_signed_in


	def create # add validation for author_id (wink wink)
		@comment = commentable_type.comments.build(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to request.referrer
    else
      flash[:error] = "There was a terrible problem with that comment"
    end
	end

	def edit
    # lol yea right
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
    # Test the refresh of the page after an error
    redirect_to request.referrer
  end

  private

  def commentable_type
  	commentable_class.find(params[parent_id])
  end

  def commentable_class
  	params[:commentable].singularize.classify.constantize
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  # thanks Andur!
  def parent_id
    "#{params[:commentable].to_s}_id".downcase.to_sym
  end

end
