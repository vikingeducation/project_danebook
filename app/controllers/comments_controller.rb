class CommentsController < ApplicationController

  def create
    @activity = Activity.find(params[:activity_id])
    if @activity.create_comment(comment_params, current_user)
      User.delay.send_alert_email(@activity.author.id)
      redirect_back(fallback_location: user_activities_path(@activity.author))
    else
      flash[:notice] = "Must have some content"
      redirect_to user_activities_path(@activity.author)
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

end
