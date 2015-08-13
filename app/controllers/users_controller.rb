class UsersController < ApplicationController

  before_action :require_login, :except => [:new, :create]
  before_action :require_current_user, :except => [:new, :create, :show]


  def new
    @user = User.new
    @user.build_profile
    redirect_to current_user if current_user
  end

  def create
    @user = User.new(whitelisted_user_params)
    if @user.save
      sign_in(@user)
      flash[:success]="Your account was successfully created!"
      redirect_to edit_user_profile_path(@user)
    else
      flash.now[:error]="We couldn't create your account."
      @user.build_profile
      render :new
    end
  end

  def show
    redirect_to user_posts_path(params[:id])
  end

  # def edit
  #   # binding.pry
  #   current_user
  # end

  def update
    redirect_to user_posts_path(params[:id]) unless photo_is_yours?
    if current_user.update(whitelisted_user_params)
      flash[:success] = "Successfully updated your profile"
      redirect_to current_user
    else
      flash.now[:failure] = "Failed to update your profile"
      render :edit
    end
  end

  # def destroy
  #   sign_out
  #   redirect_to root_path
  # end

  private

  def whitelisted_user_params
    params.require(:user).permit( :first_name, :last_name, :email,
                                  :password, :password_confirmation,
                                  :birthdate, :id, :cover_photo_id,
                                  :profile_photo_id,
                                { :profile_attributes =>
                                [ :id, :phone, :motto,
                                  :about, :college, :hometown,
                                  :location, :gender] })
  end

  def photo_is_yours?
    if params[:cover_photo_id]
      return false if current_user.id != params[:cover_photo_id].user_id.to_i
    end

    if params[:profile_photo_id]
      return false if current_user.id != params[:profile_photo_id].user_id.to_i
    end
    true
  end



end
