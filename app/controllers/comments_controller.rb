class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    # parent = params[:commentable]
    # parent_id = (parent.downcase << "_id").to_sym
    # @commentable = parent.classify.constantize.find(params[parent_id])
    # @comment = @commentable.comments.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    if @comment.save!
      flash[:success] = "Your comment has been saved!"
      redirect_to current_user
    else
      flash[:danger] = "Your comment was not posted"
      redirect_to current_user
    end
  end


  def index
  end

  def show
  end


  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  # def underscore
  #   self.gsub(/::/, '/').
  #   gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
  #   gsub(/([a-z\d])([A-Z])/,'\1_\2').
  #   tr("-", "_").
  #   downcase
  # end
end
