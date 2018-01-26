class PhotoAssignmentsController < ApplicationController

  before_action :require_current_user

  def create
    session[:return_to] ||= request.referer

    user_id = params[:user_id]
    photo_id = params[:photo_id]
    photo_type = params[:photo_type]

    @assignment = PhotoAssignment.new(user_id: user_id, photo_id: photo_id, photo_type: photo_type)

    redirect_to session.delete(:return_to)
  end


end
