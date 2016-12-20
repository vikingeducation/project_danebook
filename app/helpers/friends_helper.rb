module FriendsHelper
  def list_friends_of(user)
    friends = user.friended_users.map { |user| user.name }
    friends.join('<br>').html_safe
  end
end
