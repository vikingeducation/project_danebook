class LikesController < ApplicationController

  def create
    type = params[:likeable]
    create_context
    @like = Like.new
    @like.update_attributes(user_id: current_user.id,
                        likeable_id: @likeable.id,
                      likeable_type: type)
    @likeable.like_count += 1
    @likeable.save

    redirect_to user_timeline_url(current_user)
  end

  def destroy
    create_context
    context = @likeable.class.name.constantize
    like = @likeable.likes.find_by_user_id(current_user.id)
    like.destroy
    @likeable.like_count -= 1
    @likeable.save #go back to
    redirect_to user_timeline_url(current_user)
  end

  private

    def create_context
      if params[:likeable] == 'Post'
        @likeable = Post.find(params[:post_id])
      elsif params[:likeable] == 'Comment'
        @likeable = Comment.find(params[:comment_id])
      end
    end

end
