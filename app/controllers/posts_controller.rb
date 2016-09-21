class PostsController < ApplicationController
  before_action :required_user_redirect

  def create
    @user = current_user
    if @post = @user.posts.create(post_params)
      @activity = @post.activity
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.js {}
      end
    end
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end

end
