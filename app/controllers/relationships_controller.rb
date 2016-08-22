class RelationshipsController < ApplicationController
  before_action :signed_in_user?, only: [:create, :destroy]
  before_action :current_user, only: [:create, :destroy]

  def create
    @user = User.find(params[:friended_id])
    if current_user.friended_relationships.create(friended_id: @user.id)
      flash[:success] = "You are now friends with #{@user.name}"
      redirect_to user_profiles_path(@user)
    else
      flash[:error] = "You will never friend #{@user.name}!"
      redirect_to user_profiles_path(@user)
    end
  end

  def destroy
    @relationship1 = Relationship.find(params[:id])
    @user = User.find(@relationship1.friended_id)
    @relationship2 = Relationship.where(friended_id: current_user.id).where( friender_id: @user.id)
    if @relationship2.empty?
      flash[:success] = "Friend request deleted"
      @relationship1.destroy
      redirect_to user_profiles_path(@user)
    else
      flash[:success] = "You are no longer friends with #{@user.name}"
      @relationship2.first.destroy 
      @relationship1.destroy
      redirect_to user_profiles_path(@user)
    end
  end

end
