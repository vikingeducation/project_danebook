class LikesController < ApplicationController

  before_action :set_return_path, only: [:create, :destroy]

  def create
    klass, likable_id = parse_klass_and_id

    @likable = klass.find(params[likable_id])
    @like = @likable.likes.build(:user_id => current_user.id)

    if @like.save
      flash[:success] = "Liked!"
    else
      flash[:error] = "Something went wrong with that like."
    end

    #params too complex for render. redirect to referrer either way
    redirect_to session.delete(:return_to)
  end

  def destroy
    @like = Like.find(params[:id])

    if @like.destroy
      flash[:success] = "Unliked."
    else
      flash[:error] = "Something went wrong with that unlike."
    end

    #no matter what, redirect to referring page. params too complex for render.
    redirect_to session.delete(:return_to)
  end

  private

  def parse_klass_and_id
    klass = params[:likable].constantize
    likable_id = "#{klass}_id".downcase.to_sym
    return klass, likable_id
  end
end
