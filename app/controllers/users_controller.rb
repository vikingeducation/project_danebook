class UsersController < ApplicationController

  def new
    @user = User.new
    # @user.birthdate.build
  end

  def create

  end

  def show
  end
end
