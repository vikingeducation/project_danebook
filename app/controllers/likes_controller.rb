class LikesController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  before_action :require_like_author, only: [:destroy]

  def create
    @type = params[:likeable]
    @id = get_likeable_id

    if @type.constantize.exists?(@id)
      if already_liked?
        flash[:danger] = "You've already liked it!"
        redirect_to :back
      else
        l = Like.new(user_id: current_user.id, likeable_type: @type, likeable_id: @id.to_i)
        if l.save
          flash[:success] = "Like saved!"
          redirect_to :back
        else
          flash[:danger] = "Like not saved!"
          redirect_to :back
        end
      end
    else
      flash[:danger] = "That #{@type} Doesn't Exist!"
      redirect_to :back
    end
  end

  def destroy
    @type = params[:likeable]
    @id = get_likeable_id
    if @type.constantize.exists?(@id)
      if already_liked?
        l = get_like
        if l.destroy
          flash[:success] = "#{@type} unliked!"
          redirect_to :back
        else
          flash[:danger] = "Unlike failed!"
        end
      else
        flash[:danger] = "You haven't liked this #{@type} yet!"
        redirect_to :back
      end
    else
      flash[:danger] = "That #{@type} Doesn't Exist!"
      redirect_to :back
    end
  end

  private

  def get_likeable_id
    class_name = params[:likeable]
    class_id = (class_name.downcase + "_id").to_sym
    params[class_id]
  end

  def already_liked?
    likes = @type.constantize.find(@id).likes
    if likes && likes.any? { |l| l.user_id == current_user.id }
      return true
    else
      return false
    end
  end

  def get_like
    likes = @type.constantize.find(@id).likes
    like = likes.select { |l| l.user_id == current_user.id }
    return like[0]
  end

  def require_like_author
    likey = Like.find_by_id(params[:id])
    unless likey && likey.user_id == current_user.id
      flash[:danger] = "Not authorized! This isn't your Like!"
      redirect_to user_path(current_user)
    end
  end

end
