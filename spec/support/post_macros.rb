module PostMacros
  def fill_post(post)
    fill_in 'Description', with: post.description
    click_button("Post the Post")
  end
end