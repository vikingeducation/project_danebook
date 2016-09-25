class PostsController < ApplicationController

  def index
    @posts = Post.all
    respond_to do |format|
      format.js { render json: @posts.to_json(:include => :user) }
    end
  end

  def create
    @post = current_user.posts.build(whitelisted_post_params)
    
    if @post.save 
      # Post.delay(queue: "email", priority: 28, run_at: 5.seconds.from_now).send_trigger_email(current_user.id, @post)
      # redirect_to current_user
      flash.now[:success] = "Post was created in User"
      respond_to do |format|
        format.js {}
      end
    else
      flash[:error] = "Post was NOT! saved in User"
      respond_to do |format|
        format.js { }
      end
    end
      
    
  end

  def destroy
    @post= Post.find(params[:id])
    if @post.destroy
      flash[:success] = "Post was deleted in User"
      
      respond_to do |format|
        # format.html { render(:text => "not implemented") }
        format.js { }
      end
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
