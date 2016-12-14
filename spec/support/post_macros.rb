module PostMacros
  def create_new_post
    visit root_path
    fill_in "post_body", with: "Test New Post"
    click_button "Post"
  end
end
