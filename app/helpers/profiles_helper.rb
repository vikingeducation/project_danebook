module ProfilesHelper


  def add_gray_background_if(current_page)
    current_page?(current_page) ? 'link-background' : ''
  end


end
