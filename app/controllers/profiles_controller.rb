class ProfilesController < ApplicationController


    before_action :require_login, :except => [:show ]
    # skip_before_action :require_login, :only => [:new, :create]

    def new
      #
    end


    def index

    end

    def show
      @user = User.find(params[:user_id])
      @profile = current_user.profile
    end

    def new
      # @user = User.new
      # @user.build_profile
    end

    def create
      # @user = User.new(whitelisted_params)
      # if @user.save
      #   sign_in(@user)
      #   flash[:success] = "Welcome"
      #   redirect_to @user
      # else
      #   flash[:error] = "Try again"
      #   render :new
      # end
    end

    def edit
      @user = User.find(params[:user_id])
      @profile = @user.profile
    end

    def update
      @user = User.find(params[:user_id])
      @profile = @user.profile
      if @profile.update_attributes(whitelisted_params)
        flash[:success] = "Profile Updated"
        redirect_to user_profile_url @user
      else
        flash[:error] = "Try again"
        render :edit
      end
    end



    private


      def whitelisted_params
        params.require(:profile).permit( :motto, :college, :residing, :phone, :home_town, :about,
                                       :gender,
                                       :first_name,
                                       :last_name)
      end

end
