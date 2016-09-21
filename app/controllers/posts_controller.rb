class PostsController < ApplicationController

  def create
    session[:return_to] = request.referer
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if current_user.save

        format.html { redirect_to session.delete(:return_to)
                      flash[:success] = "Created New Post"
                    }
        format.js { flash.now[:success] = "Created New Post"
                    render :create
                     }
      else
        format.html { redirect_to session.delete(:return_to)
                      flash[:error] = "Could Not Create Post"
                    }
        format.js { head :none }
      end
    end
  end

  def destroy
    session[:return_to] = request.referer
    @post = current_user.posts.find(params[:id])
    respond_to do |format|
      if @post.destroy
        format.html { flash[:success] = "Deleted Post"
                      redirect_to session.delete(:return_to) }
        format.js { flash.now[:success] = "Deleted Post"
                    render :destroy }
      else
        format.html { flash[:error] = "Could Not Delete Post"
                      redirect_to session.delete(:return_to) }
        format.js { head :none }
      end
    end
  end


private

  def post_params
    params.require(:post).permit(:body)
  end

end
