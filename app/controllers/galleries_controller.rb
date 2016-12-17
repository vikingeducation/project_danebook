class GalleriesController < ApplicationController
  include UserCheck

  before_action :set_user
  before_action :correct_user, except: [:show]

  def index
    @galleries = @user.galleries
  end

  def show
    @gallery = Gallery.find_by(id: params[:id])
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end

end
