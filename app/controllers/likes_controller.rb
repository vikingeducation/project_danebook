class LikesController < ApplicationController

  # before_action :require_login, :except => [:show ]

#likeable_type
#Like.create(user_id: b.user_id, likeable_id: b.id, likeable_type: "Post")



  def create
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @type = params[:likeable]

    @like = Like.new


      @like.update_attributes(user_id: @user.id,
      likeable_id: @post.id,
      likeable_type: @type,
      )

      @post.increment(:like_count)

    redirect_to user_timeline_url
  end

  def destroy
    @post = Post.find(params[:id])
  end

  private





end
