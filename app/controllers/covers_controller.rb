class CoversController < ApplicationController
  def create
    @cover = Cover.new(cover_params)
    @cover
    if @cover.save
      flash[:notice] = "Cover successfully created"

    else
      flash[:notice] = "cover has not saved"
    end
    @photo = Photo.find(cover_params[:photo_id])
    @user = User.find(cover_params[:user_id])
    redirect_to :back
  end

  def update
    @cover = Cover.find(params[:id])
    @cover.photo_id = cover_params[:photo_id]
    if @cover.save
      flash[:success] = "Your cover has been updated!"
    else
      flash[:error] = "Error! The cover was not changed!"
    end
    @photo = Photo.find(cover_params[:photo_id])
    @user = User.find(cover_params[:user_id])
    redirect_to :back

  end

  def cover_params
    params.permit(:user_id, :photo_id)
  end
end
