class PostsController < ApplicationController
  def create
    @post = Post.new(:profile_id => params[:post][:profile_id],
      :body => params[:post][:body])
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
      format.js {render template: 'profiles/posts.js.erb'}
      else
        flash[:error] = "Could not save the post"
        format.html {redirect_to profile_timeline_path(params[:post][:profile_id])}
      end
    end

  end

  def destroy
    @post = Post.find(params[:id])
    if current_user && current_user.id == @post.user_id
      @post.destroy
    else
      flash[:error] = "You can only delete you own posts"
    end
    respond_to do |format|
      format.js {render template: 'profiles/posts.js.erb'}
    end
  end
end

