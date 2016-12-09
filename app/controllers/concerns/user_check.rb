module UserCheck
  extend ActiveSupport::Concern

  def correct_user
    unless params[:user_id] == current_user.id.to_s
      flash[:danger] = ["You cannot mess with other users! Jerk.."]
      redirect_to user_profile_path(current_user)
    end
  end

  def set_user
    @user = User.find_by_id(params[:user_id])
    unless @user
      flash[:danger] = ["User does not exist"]
      redirect_to root_path
    end
  end

  def set_user_full_profile
    @user = User.includes(profile: [:bio]).find_by_id(params[:user_id])
    unless @user
      flash[:danger] = ["User does not exist"]
      redirect_to root_path
    end
  end
end
