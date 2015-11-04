class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @user = User.find_by(params[:id])
    redirect_to user_path(@user)
  end
  
  def show
    @user = User.find_by(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(whitelisted_user_params)
    if @user.save
      flash[:success] = "successfully create a new user"
      sign_in(@user)
      #redirect_to user_path(@user)
    else
      flash[:errors] = "user profile creation failed for some reason"
      redirect_to root_url
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    #@user.destroy
    sign_out
    redirect_to root_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    
    def whitelisted_user_params
      params.
        require(:user).
        permit( 
          :email,
          :password,
          :password_confirmation,
          {
            :profile_attributes => [
              :first_name,
              :last_name,
              :birthday,
              :gender
              ]
          }
          )
    end
    
end
