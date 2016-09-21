class CommentsController < ApplicationController

  def create
    @activity = Activity.find(params[:activity_id])
    if @activity.create_comment(comment_params, current_user)
      User.delay.send_alert_email(@activity.author.id)
      respond_to do |format|
        format.html {redirect_back(fallback_location: user_activities_path(@activity.author))}

        format.js {}
      end
    else
      flash[:notice] = "Must have some content"
      redirect_back(fallback_location: root_path)
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

end
