class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def timeline
    @comment = Comment.new
    @post = Post.new
    @user = User.includes(:posts => [{:likes => :user}, {:comments => [:user, {:likes => :user}]}]).find_by_id(params[:id])
  end

  def search
    search_name = params[:value].downcase
    if search_name == 'all'
      @users = User.all
    else
      @users = User.search_user(search_name)
    end
  end


end
