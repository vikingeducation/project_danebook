class LikesController < ApplicationController

  def create
    klass, likable_id = parse_klass_and_id

    @likable = klass.find(params[likable_id])
    @like = @likable.likes.build(:user_id => current_user.id)

    if @likable.is_a? Post
      @user = @likable.user
    elsif @likable.is_a? Comment
      @user = @likable.commentable.user
    end

    if @like.save
      flash[:success] = "Liked!"
      redirect_to user_timeline_url(@user)
    else
      flash[:error] = "Something went wrong with that like."
      redirect_to user_timeline_url(@user)
    end

  end

  def destroy
    @like = Like.find(params[:id])

    if @like.likable.is_a? Post
      @user = @like.likable.user
    elsif @like.likable.is_a? Comment
      @user = @like.likable.commentable.user
    end


    if @like.destroy
      flash[:success] = "Unliked."
      redirect_to user_timeline_url(@user)
    else
      flash[:error] = "Something went wrong with that unlike."
      redirect_to user_timeline_url(@user)
    end
  end

  private

  def parse_klass_and_id
    klass = params[:likable].constantize
    likable_id = "#{klass}_id".downcase.to_sym
    return klass, likable_id
  end
end
