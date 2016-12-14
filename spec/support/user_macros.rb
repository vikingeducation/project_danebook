module UserMacros
  def create_session(user)
    session[:user_id] = Crypt.encrypt(user.id)
  end

  def create_friendship(user, friend)
    create(:friends_user, user: user, friend: friend)
    create(:friends_user, user: friend, friend: user)
  end

  def destroy_friendship(user, friend)
    FriendsUser.
      where(user_id: user.id, friend_id: friend.id).
      or(
        FriendsUser.
          where(user_id: friend.id, friend_id: user.id)
        ).
      destroy_all
  end
end
