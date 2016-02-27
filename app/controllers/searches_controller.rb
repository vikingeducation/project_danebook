class SearchesController < ApplicationController

  def show
    @matches = User.search(params[:query])
  end

end
