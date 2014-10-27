class CommentsController < ApplicationController
  def new


  end

  def create
    post = Post.find(params[:post_id]) 
    
    session[:return_to] ||= request.referer

    comment = current_user.comments.build do |comment|
      comment.commentable_id = post.id
      comment.body = params[:body]
      comment.commentable_type = params[:commentable_type]
    end


    if comment.save
      flash[:success] = "Comment posted"
      redirect_to session.delete(:return_to)
    else
      redirect_to root_url
    end
  end



end
