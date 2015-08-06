module PostsHelper

  def people_like_this(thing)
    total=thing.likes.length
    if total>0
      
      str="#{thing.likes[0].user.full_name} likes this" if total == 1
      str=thing.likes.inject {|sum,like| sum+="#{like.user.full_name} "}+"likes this" if total < 4 && total > 1
      str="#{total} others like this" if total >4
      str.html_safe
    else
      "No one likes this"
    end
    

  end

end
