class LikesController < ApplicationController

  before_action :require_login

  def create
  end

  def destroy
  end

  private

  def whitelisted_params
    params.require(:post_id)
  end

end
