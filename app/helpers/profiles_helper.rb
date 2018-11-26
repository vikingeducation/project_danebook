module ProfilesHelper


  def add_gray_background_if(current_page)
    current_page?(current_page) ? 'link-background' : ''
  end

  def profile_photo_present?(user)
    user.profile.profile_photo_id.nil? ? false : true 
  end


end
