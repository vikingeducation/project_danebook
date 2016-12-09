class TimelinesController < ApplicationController
  def new
  end

  def index
    #
  end

  def show
    @user = User.find(params[:id])
  end

  def create
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def destroy
  end

end
