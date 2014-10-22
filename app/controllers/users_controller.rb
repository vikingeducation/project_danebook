class UsersController < ApplicationController
  layout "login", only: [:new]

  def new
    @user = User.new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
