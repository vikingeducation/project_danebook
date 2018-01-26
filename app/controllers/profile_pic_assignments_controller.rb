class ProfilePicAssignmentsController < ApplicationController

  before_action :require_current_user

  def create
    current_user.update_attributes(profile_pic_id: params[:photo_id])
    redirect_to session.delete(:return_to)
  end

end
