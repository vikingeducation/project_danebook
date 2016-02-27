class NewsfeedsController < ApplicationController

  require 'will_paginate/array'

  # Require current user to see news feed
  before_action :require_login
  before_action :require_current_user

  def show
    @user = current_user
    @post = Post.new
    @comment = Comment.new
    @friends = @user.friends.includes(:profile_pic)
    @posts = get_friends_posts.paginate(:page => params[:page], :per_page => 10)
  end

  private

    def get_friends_posts
      # posts = @user.posts_received.includes( author: :profile_pic,
      #                                       comments: :author,
      #                                       likes: :user )
      posts = []
      @friends.each do |friend|
        posts += friend.posts.includes(:author, likes: :user)
      end
      posts
    end

end
