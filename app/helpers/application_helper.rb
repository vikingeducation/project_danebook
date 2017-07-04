module ApplicationHelper

  def formatted_date(date)
    date.strftime("Posted on %A %d/%m/%Y")
  end

  def list_who_liked(post)
    str = ""
    first_few_likes(post).each do |link|
      if link.id == current_user.id
        str += "You"
      else
        str += link_to("#{full_name(link)}", link.user, class: "liking")
      end
      str += 'and' unless first_few_likes(post).last == link
    end
    str.html_safe
  end

end
