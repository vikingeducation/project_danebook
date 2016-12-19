class FriendsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @timeline_posts = Post.where(user_id: @user.friended_users).or(Post.where(user_id: @user))
    @post = current_user.posts.build
  end

  def create
    @user = User.find(params[:user_id])
    if current_user.friended_users << @user
      flash[:success] = "#{@user.name} is now your friend!"
    else
      flash[:warning] = "Could not befriend #{@user.name}."
    end
    redirect_back(fallback_location: user_profile_path(@user))
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.friended_users.delete(@user)
    flash[:success] = "No longer friends with #{@user.name}."
    redirect_back(fallback_location: user_profile_path(@user))
  end

end
