module ApplicationHelper

  def author_of?(obj, user)
    obj.user.id == user.id
  end

end
