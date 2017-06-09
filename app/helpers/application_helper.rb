module ApplicationHelper

  def author_of?(obj, user)
    obj.user.id == user.id
  end

  def humanize_date(date)
    if date
      date.strftime '%b %d, %Y'
    else
      "-"
    end
  end

end
