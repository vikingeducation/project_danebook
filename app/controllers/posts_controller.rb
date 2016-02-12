class PostsController < ApplicationController

  before_action :require_login

  def new
    @post = Post.new
  end







end
