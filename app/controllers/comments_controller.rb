class CommentsController < ApplicationController

  def create
    @activity = Activity.find(params[:activity_id])
    @activity.create_comment(comment_params, current_user)
    redirect_to user_activities_path(@activity.author)
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

end
