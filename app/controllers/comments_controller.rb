class CommentsController < ApplicationController

  def create
    #if its on a post
    if params[:post_id]
      @post = Post.find(params[:post_id])
      parent_id = params[:post_id]
      @user = @post.user
      type = "Post"
    #if its on a photo
    else
      @photo = Photo.find(params[:photo_id])
      @user = @photo.user
      parent_id = params[:photo_id]
      type = "Photo"
    end
    @comment = Comment.new(:commentable_id => parent_id.to_i,
                          :commentable_type => type,
                          :user_id => current_user.id,
                          :body => params[:comment][:body])
    respond_to do |format|
      if @comment.save
        User.delay(run_at: 5.seconds.from_now).send_comment_email(@user.id, current_user.id, type)
        format.html{
          if type == "Photo"
            redirect_to user_photo_path(@user, @photo)
          elsif type == "Post"
            redirect_to user_posts_path(@user)
          end
        }
        format.js{}
      else
        format.html{
          redirect_to user_posts_path(@user) 
        }
        format.js{head:none}
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if params[:post_id]
      @post = Post.find(params[:post_id])
      @user = @post.user
    else
      @photo = Photo.find(params[:photo_id])
      @user = @photo.user
    end
    @comment.destroy
    respond_to do |format|
      format.js{}
      format.html{
        if params[:post_id]
          redirect_to user_posts_path(@user)
        elsif params[:photo_id]
          redirect_to user_photo_path(@user, @photo)
        end  
      }
    end
  end

end
