class CommentsController < ApplicationController
    before_action :require_login, :except => [:show ]
    #
    # @commentable = extract_commentable
    # @comment = @commentable.comments.build(comment_params)
    # @comment.author = current_user
    # resource :session, only: [:new, :create, :destroy]



    def create
      @post = Post.find(params[:post_id])
      @user = current_user
      @comment.build(whitelisted_params)
      @type = params[:commentable]

      @comment.update_attributes(user_id: @user.id,
                             commentable_id: @post.id,
                           commentable_type: @type)

      @comment.save
      redirect_to user_timeline_url(current_user)


    end

    def destroy
      @post = Post.find(params[:post_id])
      @like = @post.likes.find_by_user_id(current_user.id)
      # @post.likes.find_by_user_id(current_user)

      @like.destroy

      @post.like_count -= 1
      @post.save

      redirect_to user_timeline_url(current_user)
    end

    private
    def whitelisted_params
      params.require(:comment).permit(:body)
    end






end
