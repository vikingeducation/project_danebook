class LoginsController < ApplicationController
  def new
    @user = User.new
    render "users/new"
  end
end
