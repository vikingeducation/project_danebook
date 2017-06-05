module PostMacros
  def write_post(user)
    visit user_profile_path(user)
    fill_in 'post[body]', with: 'The quick brown fox'
  end
  def create_post(user)
    visit user_profile_path(user)
    fill_in 'post[body]', with: 'The quick brown fox'
    click_button 'Post'
  end
end
