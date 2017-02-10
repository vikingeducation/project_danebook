module ApplicationHelper

  def posted_on(time)
    time.strftime("Posted on %m/%d/%Y")
  end

end
