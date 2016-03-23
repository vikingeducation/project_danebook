class FriendshipsController < ApplicationController

  before_action :require_login
  before_action :require_current_user, :only => [:destroy]

  def index
    @user = User.find(params[:user_id])
    @friends = @user.friends
  end
    
  def create

    @friendship = current_user.initiated_friend_requests.build(friend_receiver_id: params["user_id"])

    if @friendship.save
       flash[:success] = "Friended!"
    else 
      flash[:alert] = "Could not friend! "
    end

    redirect_user_path(params[:user_id])

  end 

  def destroy

    if @friendship = Friendship.find_by_id(params[:id])

      if @friendship.destroy
        flash[:success] = "Unfriended"
      else
        flash[:alert] = "Could not unfriend"
      end

      redirect_user_path(params[:user_id])
    else
      flash[:alert] = "Invalid friendship removal! - Unauthorized?"
      redirect_to root_url
    end  
  end 


  private
  def redirect_user_path(user_id)
    if user_id == current_user.id.to_s
      redirect_to new_user_post_path(user_id)
    else
      redirect_to user_posts_path(user_id)
    end 
  end

end