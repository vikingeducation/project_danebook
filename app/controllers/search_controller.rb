class SearchController < ApplicationController
  def show
    if params[:search] == ""
      @profiles = Profile.all
    else
      @profiles = Profile.where('UPPER(first_name) like ? OR UPPER(last_name) like ?', "%#{params[:search].upcase}%", "%#{params[:search].upcase}%")
    end
  end
end
