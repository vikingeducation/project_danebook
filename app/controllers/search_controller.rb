class SearchController < ApplicationController
  def search
    if params[:q].nil?
      flash[:danger] = "Sorry we couldn't find anyone by that name"
      redirect_to users_path
    else
      # @users = search_user_profile(params[:q])
      sldjf
      @users = User.custom_search(params[:q]).results
    end
  end

  private

  def search_user_profile(q)
    Elasticsearch::Model.search(q, [User, Profile]).records.to_a
  end
end
