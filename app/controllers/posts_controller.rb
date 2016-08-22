class PostsController < ApplicationController
  before_action :required_user_redirect

  def create
    @user = current_user
    @user.posts.create(post_params)
    redirect_back(fallback_location: root_path)
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end

end
