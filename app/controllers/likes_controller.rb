class LikesController < ApplicationController

  before_action :require_login

  def create
  end

  # def index
  #   @likes = extract_likings.likes

  # end

  # private

  # def extract_likings
  #   resource, id = request.path.split('/')[1,2]
  #   resource.singularize.classify.constantize.find(id)
  # end
end
