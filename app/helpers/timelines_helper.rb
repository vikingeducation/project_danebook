module TimelinesHelper

  def no_pictures_message(user)
    if user.photos.empty?
      "This user hasn't uploaded any photos yet"
    end
  end

  def no_friends_message(friends)
    if friends.empty?
      "This user hasn't added any friends yet :("
    end
  end


end
