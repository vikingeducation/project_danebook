class CoverPicAssignmentsController < ApplicationController

  before_action :require_current_user

  def create
    session[:return_to] ||= request.referer

    current_user.update_attributes(cover_pic_id: params[:photo_id])
    redirect_to session.delete(:return_to)
  end

end
