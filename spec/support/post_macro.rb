module PostMacros
  def make_post_on_own_timeline
    visit root_path
    click_link "Timeline"
    fill_in 'post[description]', with: "new post description"
    click_button "Post"
  end

  def make_comment_on_post
    within(".new_comment") do
      fill_in "comment[description]", with: "comment description"
      click_button "Comment"
    end
  end
end
