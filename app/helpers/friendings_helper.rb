module FriendingsHelper
  def friending_link(user)
    if current_user.already_friended?(user)
      link_to("Unfriend", friending_path(user), class: "btn btn-danger btn-lg", method: "delete")
    else
      link_to("Friend Me!", friendings_path, method: "post", class: "btn btn-danger btn-lg")
    end
  end
end
