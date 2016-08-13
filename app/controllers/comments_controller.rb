class CommentsController < ApplicationController
  skip_before_action :correct_user

  def update
    raise
  end

  def destroy
  end

  private

    def comment_params
      params.require(:comment).permit(:body,
                                      { likes_attributes: [] })
    end
end
