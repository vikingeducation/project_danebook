module PostsHelper
  def profile_helper(field)
    if field && !field.blank?
      field
    else
      "This user has not yet added this information!"
    end
  end

  def display_like_or_unlike_button(likable)
    if current_user.likes? (likable)
      link_to "Unlike", likes_path(user_id: current_user.id, likable_id: likable.id, likable_type: likable.class), method: 'delete', data: { confirm: "Sure?" }, remote: true
    else
      link_to "Like", likes_path(likable_id: likable.id, likable_type: likable.class), method: 'post', remote: true
    end
  end

  # Generates a string depicting who likes a given likable.
  # Links to friended users that like a given likable as well.
  def present_likes_count(likable)
    # Get all the people that like a post
    people_who_like = likable.people_who_like
    if current_user

      # Get the intersection of you & your friends, and people that like a post.
      user_and_friends_that_like = ((current_user.friends + [current_user]) & people_who_like)

      # Get the friends that like a post which is the above minus you.
      friends_that_like = user_and_friends_that_like - [current_user]

      # Limit the amount of friends to 3 randomly selected ones.
      friends_that_like = friends_that_like.sample(3)

      likes_array = []
      likes_array << "You" if people_who_like.include?(current_user)
      likes_array += links_to_friends(friends_that_like)
      likes_array << others_that_like(people_who_like, user_and_friends_that_like)
      likes_array.delete("")
      if likes_array.length == 1
        if likes_array[0] == "You"
          return "You like this."
        else
          return likes_array[0].to_s + pluralize(people_who_like.length, " likes", " like")[2..-1] + " this."
        end
      else
        return likes_array[0..-2].join(", ") + " and " + likes_array[-1].to_s + " like this."
      end
    else
      return pluralize(people_who_like.count, " person likes this", "people like this")
    end
  end

  def links_to_friends(friends)
    friends.map{|friend| link_to friend.full_name, friend}
  end

  # Returns a count based on all non-friended users that like a given likable.
  def others_that_like(people, associates)
    if associates.length > 0
      if (people - associates).length > 0
        return pluralize((people - associates).length, 'other person ', "other people ")
      end
    elsif people.length > 0
      return pluralize(people.length, 'person ', 'people ')
    end
    ""
  end
end
