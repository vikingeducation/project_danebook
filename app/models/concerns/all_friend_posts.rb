module AllFriendPosts

  extend ActiveSupport::Concern

  module ClassMethods

    def all_friend_posts(current_user)
      friend_posts = []
      if current_user.friends.any?
        current_user.friends.each do |friend|
          friend.authored_posts.each do |post|
            friend_posts << post
          end
        end
      end
      friend_posts.sort_by! { |post| post.updated_at }
      friend_posts.reverse
    end

  end
end