class UsersController < ApplicationController

  before_action :set_user_and_profile, only: [:show, :edit, :update, :destroy]
  before_action :require_login, :except => [:new, :create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  # def index
  #   @users = User.all
  # end

  def show
  end

  def new
    @user = User.new
    @user.build_profile
  end

  def search
    @user = User.find_by_email(params[:email])
    if @user
       redirect_to user_path(@user)
    else
      redirect_to :back
    end

    # if params[:query]
     
    #   first_name = params[:query].split(" ")[0]
    #   last_name = params[:query].split(" ")[0]  
    #   where("title LIKE ?", "%#{query}%")
    # else
    #   # If no search term provided, this returns
    #   # a relation so we can chain this
    #   where("")
    # end

  end
    
  def edit
  end

  def create

    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "#{@user.email} was signed up was successfully!"
      sign_in(@user)
      redirect_to edit_user_path(@user)
    else
      flash[:alert] = "Your sign up was NOT successfull!"
      render :new
    end

  end

  def update
    if current_user.update(user_params)
        flash[:success] = "#{@user.email} was updated successfully!"
        redirect_to user_path(@user)
    else    
      flash[:alert] = "Your update was NOT successfull!"
      render :edit
    end
  end

  def destroy
    if current_user.destroy
      flash[:success] = "#{current_user.email} was removed!"
      sign_out      
      redirect_to new_user_path
    else    
      flash[:alert] = "#{current_user.email} could not be removed!"
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_and_profile
      @user = User.find(params[:id])
      @profile = @user.profile
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params

      params.require(:user).permit(
        :username,
        :email,
        :password,
        :password_confirmation,
        {:profile_attributes => [
         :id,
         :user_id,
         :college, 
         :first_name, 
         :last_name, 
         :hometown,
         :domicile,
         :birthdate,
         :about_me,
         :gender,
         :my_words ] }
      )
    end
end