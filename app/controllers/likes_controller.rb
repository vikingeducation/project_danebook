class LikesController < ApplicationController

  def index
  end

  def show
  end

  def new
    @like = Like.new
  end

  def create
    @like = Like.new(:likeable_id, :user_id, :likeable_type)
    @like.save
  end

  def destroy
  end

  private

  # def like_params
  #   params.require(:like).permit(:likeable_id, :user_id, :likeable_type)
  # end

end
