class ProfilesController < ApplicationController

  def update
    
    @profile = Profile.find(params[:id])
    if params[:profile][:image_id] 
      @profile.image_id = params[:profile][:image_id]
    end 
    if params[:profile][:cover_id] 
      @profile.cover_id = params[:profile][:cover_id]
    end
    if @profile.update(profile_image_params)
        flash[:success] = "Profile update successfully!"
        redirect_to :back
    else    
      flash[:alert] = "Your update was NOT successfull!"
      redirect_to :back
    end  
  end 

  private
  
  def profile_image_params
    params.require(:profile).permit(
      :image_id,
      :cover_id
    )
  end

end