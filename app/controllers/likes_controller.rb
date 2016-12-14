class LikesController < ApplicationController

  before_action :require_login, :except => [:show]

#Like.create(user_id: b.user_id, likeable_id: b.id, likeable_type: "Post")

  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @type = params[:likeable]

    @like = Like.new

    @like.update_attributes(user_id: @user.id,
    likeable_id: @post.id,
    likeable_type: @type)

    @post.like_count += 1
    @post.save
    redirect_to user_timeline_url(current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by_user_id(current_user.id)
    # @post.likes.find_by_user_id(current_user)

    @like.destroy

    @post.like_count -= 1
    @post.save

    redirect_to user_timeline_url(current_user)
  end

  private

    def context
      if params[:likeable_type] == 'Post'
        #
      elsif params[:likeable_type] == 'Comment'
        #
      end
    end


end
