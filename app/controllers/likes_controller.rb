class LikesController < ApplicationController

  def create
    klass = params[:likable].constantize
    likable_id = "#{klass}_id".downcase.to_sym

    @likable = klass.find(params[likable_id])
    @like = @likable.likes.build(:user_id => current_user.id)

    if @like.save
      flash[:success] = "Liked!"
      redirect_to user_posts_url(current_user)
    else
      flash[:error] = "Something went wrong with that like."
      redirect_to user_posts_url(current_user)
    end

  end

  def destroy

  end
end
