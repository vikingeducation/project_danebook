class NewsfeedController < ApplicationController

  ### OMG MAKE A NTOE OF THISSS!!!!!!!!!!

  def show
    @posts = Post.limit(10).order('created_at DESC').where('user_id IN (?)', current_user.friendee_ids)
  end
end
