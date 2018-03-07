class PostsController < ApplicationController
  include ActionView::Helpers::TextHelper

  before_action :set_post, only: [:edit, :update, :destroy]

  def edit
    authorize @post
  end

  def create
    session[:return_to] ||= request.referer

    post = current_user.posts.new(post_params)
    authorize post
    if post.save
      redirect_to session.delete(:return_to), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    session[:return_to] ||= request.referer

    if @post.update(post_params)
      redirect_to session.delete(:return_to), notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    session[:return_to] ||= request.referer

    authorize @post
    @post.destroy
    redirect_to session.delete(:return_to), notice: "Post '#{truncate(@post.body, length: 25)}' was successfully destroyed."
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:body)
    end
end
