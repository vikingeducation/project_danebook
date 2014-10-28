module ApplicationHelper
  def interactive_navbar
    if signed_in?
      render 'shared/search'
    else
      render 'shared/sign_in'
    end
  end
end
