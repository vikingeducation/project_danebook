class SearchController < ApplicationController

  def index
    @users = User.search(permitted_params[:query])
  end

  def permitted_params
    params.permit(:query)
  end

end
