class PostsController < ApplicationController

  def index
    @profile = User.find(params[:user_id])
  end

  def show

  end

end
