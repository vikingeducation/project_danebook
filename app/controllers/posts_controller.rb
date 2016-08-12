class PostsController < ApplicationController

  def create
    @user = current_user
    @user.posts.create(user_params)
    redirect_to user_activities_path(@user)
  end

  private

    def user_params
      params.require(:post).permit(:content)
    end

end
