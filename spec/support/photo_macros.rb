module PhotoMacros
  def upload_photo
    page.attach_file('Add Photo', '/app/assets/images/icon_photo_small.png')
  end
end