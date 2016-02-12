class ProfilesController < ApplicationController

  before_action :require_login, only: [:show]
  before_action :require_current_user, only: [:edit, :update]

  def show
  end

  def edit
  end

  def update
  end
end
