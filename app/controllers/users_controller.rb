class UsersController < ApplicationController

  def new
   if current_user 
    redirect_to current_user
    else
     @user=User.new
   end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Danebook, #{@user.first_name}!"
      sign_in(@user)
      redirect_to @user
    else
      flash[:error] = "Error, please try again"
      render 'new'
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "User \"#{@user.first_name} #{@user.last_name}\" has been successfully updated!"
      redirect_to current_user
    else
      flash.now[:error] = "User did not update, please try again"
      render 'edit' # something wasn't right, give them another chance
    end
  end



  def show
    @user = User.find(params[:id])
    if @user.location_id
      @hometown = Location.get_location(@user.location_id).to_s
    end
    if @user.current_location_id
      @current = Location.get_location(@user.current_location_id).to_s
    end
  end

  private

  def user_params
    params.require(:user)
    .permit(:first_name, :last_name,
         :email, :gender, :birth_month,
         :birth_day, :birth_year, :password, :password_confirmation,
         :words, :about, :phone,
         :location_attributes => [
          :city,
          :country,
          :id],
         :school_attributes => [
          :id,
          :name]
         )
  end




end
