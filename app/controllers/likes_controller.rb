class LikesController < ApplicationController
  def new 
    session[:return_to] ||= request.referer
    @post = Post.find(params[:post])
    @user = User.find(params[:user])


    if params[:comment]
      @comment = Comment.find(params[:comment])

      if Like.create_comment_like(@user,@comment)
        flash[:success] = "You liked it!"
        redirect_to session.delete(:return_to)
      else
        flash[:error] = "Error liking"
        redirect_to session.delete(:return_to)
      end

    else
      if Like.create_like(@user,@post)
        flash[:success] = "You liked it!"
        redirect_to session.delete(:return_to)
      else
        flash[:error] = "Error liking"
        redirect_to session.delete(:return_to)
      end
    end

    
    

  end

  def destroy
    @post = Post.find(params[:post])
    @user = User.find(params[:user])
    session[:return_to] ||= request.referer

    if params[:comment]
      @comment = Comment.find(params[:comment])
      if Like.destroy_like(@user,@comment)
        flash[:success] = "You unliked!"
        redirect_to session.delete(:return_to)
      else
        flash[:error] = "Error unliking!"
        redirect_to session.delete(:return_to)
      end

    else
      if Like.destroy_like(@user,@post)
        flash[:success] = "You unliked!"
        redirect_to session.delete(:return_to)
      else
        flash[:error] = "Error unliking!"
        redirect_to session.delete(:return_to)
      end
    end

  end


end
