class FriendshipsController < ApplicationController
  before_action :require_current_user
  before_action :set_friendship


  private
  def set_friendship
  end

  def friendship_params
  end
end
