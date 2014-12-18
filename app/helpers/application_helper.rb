module ApplicationHelper
  def interactive_navbar
    if signed_in?
      render 'shared/search'
    else
      render 'shared/sign_in'
    end
  end

  def delete_button(object, parent=nil)
    if current_user && object.author == current_user
      link_to "Delete", [parent, object], method: "DELETE",
        data: { confirm: "Are you sure you want to delete?" }, remote: true
    end
  end
end
