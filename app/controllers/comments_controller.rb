class CommentsController < ApplicationController


  def create
  id_sym = (params[:commentable].downcase+"_id").to_sym
  @commentable = params[:commentable].constantize.find(params[id_sym])
  @comment = Comment.new(:commentable_id => @commentable.id,
                          :commentable_type => params[:commentable],
                          :user_id => current_user.id,
                          :body => params[:comment][:body])
    respond_to do |format|
      if @comment.save
        User.delay(run_at: 5.seconds.from_now).send_comment_email(@commentable.user, current_user, params[:commentable])
        format.html{
          if params[:commentable] == "Photo"
            redirect_to user_photo_path(@commentable.user, @commentable)
          elsif params[:commentable] == "Post"
            redirect_to user_posts_path(@commentable.user)
          end
        }
        format.js{}
      else
        format.html{
          redirect_to user_posts_path(@commentable.user) 
        }
        format.js{head:none}
      end
    end
  end

  def destroy
    id_sym = (params[:commentable].downcase+"_id").to_sym
    @commentable = params[:commentable].constantize.find(params[id_sym])
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js{}
      format.html{
        if params[:post_id]
          redirect_to user_posts_path(@commentable.user)
        elsif params[:photo_id]
          redirect_to user_photo_path(@commentable.user, @commentable)
        end  
      }
    end
  end

end
