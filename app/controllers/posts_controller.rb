class PostsController < ApplicationController
  def create
    @post = current_user.posts.build(whitelisted_post_params)

    if @post.save 
      Post.delay(queue: "email", priority: 28, run_at: 5.seconds.from_now).send_trigger_email(current_user.id, @post)

      redirect_to current_user
      flash[:success] = "Post was created in User"
    else
      flash[:error] = "Post was NOT! saved in User"
      redirect_to current_user
    end
  end

  def destroy
    @post= Post.find(params[:id])
    if @post.destroy
      flash[:success] = "Post was deleted in User"
      redirect_to current_user
    else
      flash[:error] = "Post was NOT! deleted in User"
      redirect_to current_user
    end
  end

  private
    def whitelisted_post_params
      params.
        require(:post).
        permit( :description, 
                :photo_attributes => [:label, :avatar])
    end
end
