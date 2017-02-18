class CommentsController < ApplicationController
  
  def create
    @post = Post.find_by_id(params[:post])
    @photo = Photo.find_by_id(params[:photo])
    if @post
      @user = @post.author
      @comment = @post.comments.build(author_id: current_user.id, body: params[:comment][:body])
    elsif @photo
      @user = @photo.owner
      @comment = @photo.comments.build(author_id: current_user.id, body: params[:comment][:body])
    end
    if @comment.save
      flash.now[:success] = "Sweet comment bro!"
      respond_to do |f|
        f.js { render :create_success }
        f.html { go_back }
      end
    else
      flash[:error] = "Oops! Something went wrong. Our apes are researching this problem as we speak."
      go_back
    end
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    commentable_thing = @comment.commentable
    @user = commentable_thing.author if commentable_thing.is_a?(Post)
    @user = commentable_thing.owner if commentable_thing.is_a?(Photo)
    @photo = commentable_thing if commentable_thing
    if @comment.destroy
      flash[:success] = "We nuked it dawg! It is gone!"
      go_back
    else
      flash[:error] = "Oops! Something went wrong. Our apes are researching this problem as we speak."
      go_back
    end
  end

end
