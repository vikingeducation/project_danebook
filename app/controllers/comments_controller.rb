class CommentsController < ApplicationController
  def create
    if params[:post_id]
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(whitelisted_params)
      @comment.author = current_user
      if @comment.save 
        flash[:success] = "You commented on #{@post.author.name}'s post."
        redirect_to user_timeline_path(@post.author)
      else
        flash[:error] = @comment.errors.full_messages.join(', ')
        @user = current_user
        @page_owner = @post.author
        render 'posts/show'
      end
    elsif params[:photo_id]
      @photo = Photo.find(params[:photo_id])
      @comment = @photo.comments.build(whitelisted_params)
      @comment.author = current_user
      if @comment.save 
        flash[:success] = "You commented on #{@photo.owner.name}'s photo."
        redirect_to user_photo_path(@photo.owner, @photo)
      else
        flash[:error] = @comment.errors.full_messages.join(', ')
        @user = current_user
        @page_owner = @photo.owner
        render 'photos/show'
      end
    end
  end



  private 

  def whitelisted_params
    params.require(:comment).permit(:id, :body)
  end

end
