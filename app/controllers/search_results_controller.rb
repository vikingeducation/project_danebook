class SearchResultsController < ApplicationController

  def index
    @results = User.with_names_like(search_params)
    @search_params = search_params
    render 'search_results/index'
  end


  private

  def search_params
    params.require(:search)
  end
end
