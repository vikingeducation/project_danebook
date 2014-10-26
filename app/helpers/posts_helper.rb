module PostsHelper

  def get_like_count(post,user) #this shows the number of people who like a given post
    case post.likes.count

    when 1
      if get_you(post,user)
        get_you(post,user) + " like" 
      else
        get_others(post.likes.first.user_id)+ " likes"
      end

    when 2
      if get_you(post,user)
        get_you(post,user) + ", " + get_others(nil,post,1) + " like"
      else
        get_others(nil,post,2)+ " like"
      end
    else
      modified_count = post.likes.count - 2 
      if get_you(post,user)
        get_you(post,user) + ", " + get_others(nil,post,1) + " and #{modified_count} others like"
      else
        get_others(nil,post,3)+ " and #{modified_count} others like"
      end
    end

  end

  private
  def get_you(post,user)
    #current_user likes this? show "you"
    if post.likes.any? {|post| post.user_id == user.id} 
      link_to("You",user_path(user))
    else
      false
    end
  end

  def get_others(user_id=nil,post=nil,times=1)
    if post.nil?
      user=User.find(user_id)
      link_to(user.first_name + " " + user.last_name,user_path(user))
    else
      users=post.likes.pluck(:user_id) #get all user ids who like the post

      if times == 1
        first_user = User.find(users.sample)
        
        while first_user == current_user #make sure 2nd and second aren't equal
          first_user = User.find(users.sample)
        end

        return link_to(first_user.first_name + " " + first_user.last_name,user_path(first_user))
      elsif times == 2
        @combiner = " and "
      else
        @combiner = ", "
      end
        first_user = User.find(users.sample)
        second_user = User.find(users.sample)

        while second_user == first_user #make sure 2nd and second aren't equal
          second_user = User.find(users.sample)
        end

        link_to(first_user.first_name + " " + first_user.last_name,user_path(first_user)) + @combiner + link_to(second_user.first_name + " " + second_user.last_name,user_path(second_user))
    end
  end

  


end
