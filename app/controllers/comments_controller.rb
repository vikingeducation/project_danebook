class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    parent = params[:commentable]
    parent_id = (parent.downcase << "_id").to_sym
    @commentable = parent.classify.constantize.find(params[parent_id])
    @comment = @commentable.comments.build(comment_params)
    @comment.user = User.find_by_id(@comment.commentable.user_id)
    @comment.from = current_user.id
    if @comment.save
      flash[:success] = "Your comment has been saved!"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Your comment needs to have content in it"
      redirect_back(fallback_location: root_path)
    end
  end


  def index
  end

  def show
  end


  private

  def comment_params
    params.require(:comment).permit(:content, :from)
  end

  # def underscore
  #   self.gsub(/::/, '/').
  #   gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
  #   gsub(/([a-z\d])([A-Z])/,'\1_\2').
  #   tr("-", "_").
  #   downcase
  # end
end
