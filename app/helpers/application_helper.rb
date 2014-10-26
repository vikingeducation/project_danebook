module ApplicationHelper
  def month_to_text(int)
    months = {
      1 => "January",
      2 => "February",
      3 => "March", 
      4 => "April",
      5 => "May",
      6 => "June",
      7 => "July",
      8 => "August",
      9 => "September",
      10 => "October",
      11 => "November",
      12 => "December"
    }

    months[int]
  end

  ########## comment helper ##########



  def get_comment_like_count(comment,user) #this shows the number of people who like a given comment
    case comment.likes.count

    when 1
      if get_you(comment,user)
        get_you(comment,user) + " like" 
      else
        get_others(comment.likes.first.user_id)+ " likes"
      end

    when 2
      if get_you(comment,user)
        get_you(comment,user) + ", " + get_others(nil,comment,1) + " like"
      else
        get_others(nil,comment,2)+ " like"
      end
    else
      modified_count = comment.likes.count - 2 
      if get_you(comment,user)
        get_you(comment,user) + ", " + get_others(nil,comment,1) + " and #{modified_count} others like"
      else
        get_others(nil,comment,3)+ " and #{modified_count} others like"
      end
    end

  end

  private
  def get_you(comment,user)
    #current_user likes this? show "you"
    if comment.likes.any? {|comment| comment.user_id == user.id} 
      link_to("You",user_path(user))
    else
      false
    end
  end

  def get_others(user_id=nil,comment=nil,times=1)
    if comment.nil?
      user=User.find(user_id)
      link_to(user.first_name + " " + user.last_name,user_path(user))
    else
      users=comment.likes.pluck(:user_id) #get all user ids who like the comment

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
