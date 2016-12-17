class NoticesController < ApplicationController

  def index
    @notices = current_user.notices
  end

  def show
    @notice = Notice.find_by(user_id: current_user.id, id: params[:id])
    set_viewed if @notice
  end

  def destroy
    Notice.find_by(user_id: current_user.id, id: params[:id]).destroy
    flash[:info] = ["Notice deleted."]
    redirect_to root_path
  end

  private
    def set_viewed
      unless @notice.viewed
        @notice.update_attribute(:viewed, true)
      end
    end
end
