class FriendingsController < ApplicationController

  def create
    @friending = Friending.new(friender: current_user.id, friendee: friending_params[:friendee])
    if @friending.save
      flash[:success] = 'Friend request sent!'
      redirect_to user_timeline_path(friending_params[:friendee])
    else
      flash[:error] = 'Something went wrong :('
      redirect_to root_url
    end
  end

  def index
    @user = User.find(params[:user_id])
    @friends = @user.friends
    render 'static_pages/friends'
  end

  def destroy
    @friending = Friending.where('friender=?', current_user.id).where('friendee=?', params[:id].to_i).first
    if @friending
      @friending.destroy
      flash[:success] = 'Unfriended'
      redirect_back(fallback_location: root_url)
    else
      flash[:error] = 'Unable to do that'
      redirect_back(fallback_location: root_url)
    end
  end


  private

  def friending_params
    params.require(:friending).permit(:friendee)
  end
end
