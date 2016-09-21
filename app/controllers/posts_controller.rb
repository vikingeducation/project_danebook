class PostsController < ApplicationController
  before_action :require_login, :except => [:show]

  def create
    if signed_in_user?

      @user = current_user
      @post =@user.text_posts.create(white_listed_posts_params)
      respond_to do |format|
        if @post.id.nil?
          flash[:danger] = "Uh ohhh something went wrong"
          format.js { head :none }
        else
          flash[:success] = "Ehhh way to go fonz"
          format.html { redirect_to :back }
          format.js { }
        end
      end
    else
      flash[:danger] = "Please sign in"
      redirect_to login_path
    end
  end

  def update

  end

  def destroy
    current_user

    if @post = get_instance(params[:id], Post)
      @id = @post.id
      respond_to do |format|
        if @post.destroy
          flash[:success] = "You successfully destroyed that post..."
          format.html { redirect_to :back }
          format.js { }
        else
          flash[:danger] = "We were unable to destroy the comment, perhaps its gone sentinel...."
          format.html { redirect_to :back }
          format.js { head :none }
        end
      end
    else
      flash[:danger] = "record not found"
      redirect_to :back
    end
  end

  private

    def white_listed_posts_params
      params.require(:post).permit(:description)
    end
end
