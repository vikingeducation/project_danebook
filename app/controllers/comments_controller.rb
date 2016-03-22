class CommentsController < ApplicationController

  def create
    params_id = "#{params[:commentable]}_id".downcase.to_sym
    @parent = params[:commentable].constantize.find(params[params_id])
    @comment = @parent.comments.create(author_id: current_user.id, body: params[:comment_body])

    respond_to do |format|
      if @comment.save
        #User.send_notification(find_parent_id(@parent), current_user.id, @parent)
        format.html { redirect_to :back }
        format.js
      else
        format.html { redirect_to :back }
        format.js
      end

    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to :back }
        format.js
      else
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  private

    def find_parent_id(parent)
      if parent.is_a?(Photo)
        id = parent.user_id
      else
        id = parent.author_id
      end
      id
    end
end
