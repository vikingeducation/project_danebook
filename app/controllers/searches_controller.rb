class SearchesController < ApplicationController

  before_action :require_login

  def show
    @matches = User.search(params[:query])
  end

end
