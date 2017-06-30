module ApplicationHelper

  def formatted_date(date)
    date.strftime("Posted on %A %d/%m/%Y")
  end

end
