class SearchesController < ApplicationController
  before_action :require_login

  def index
    @resource = 'users'
    @results = User.search(params[:q])
    @q = params[:q]
  end
end
