module TimelinesHelper
  include UsersHelper
  include PhotosHelper

  def render_friend_box(friend)
    render partial: 'static_pages/friend_box', locals: { friend: friend }
  end

end
