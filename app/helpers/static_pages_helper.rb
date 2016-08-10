module StaticPagesHelper

  def editing_profile?
    action_name == "about_edit"
  end

end
