class UsersController < ApplicationController
  skip_before_action :require_sign_in, :only => [:new, :create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]
end
