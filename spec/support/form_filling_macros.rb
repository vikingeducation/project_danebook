module FormFillingMacros

  def write_post
    post_body = 'This is a sample post'
    fill_in('post[body]', with: post_body)
    within('div.post-form') do
      click_button('Post')
    end
  end

  def write_comment
    comment_body = 'sample comment'
    fill_in('comment[body]', match: :first, with: comment_body)
    click_button('Comment')
  end

end
