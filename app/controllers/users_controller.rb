class UsersController < ApplicationController
  before_action :set_user, :except => [:new, :create]
  before_action :require_login, :except => [:index, :new, :create, :show]
  before_action :require_current_user, :only => [:edit, :update, :destroy]



# GET /users
# GET /users.json
def index
  @users = User.all
end

# GET /users/1
# GET /users/1.json
def show
  redirect_to user_profile_path(@user.id, @user.profile.id)
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
  @user = User.new(user_params)

  respond_to do |format|
    if @user.save
      sign_in(@user)
      format.html { redirect_to user_timeline_path(@user), notice: 'User was successfully created.' }
      format.json { render :show, status: :created, location: @user }
    else
      format.html { render "/sessions/new" }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end

# PATCH/PUT /users/1
# PATCH/PUT /users/1.json
def update
end

# DELETE /users/1
# DELETE /users/1.json
def destroy
end


  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.
        require(:user).
        permit( :first_name,
                :last_name,
                :email,
                :password,
                :password_confirmation,
                :birth_date)
    end

    def require_current_user
      unless current_user == User.find(params[:id])
        flash[:error] = "Access denied!!!"
        redirect_to root_path
      end
    end
end
