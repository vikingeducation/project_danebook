module LoginMacros
  def sign_in(user)
    visit root_path
    # save_and_open_page
    # print page.html
    within("#login") do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button "Log in"
    end
  end

  def sign_out
    visit root_path
    click_link "Logout"
  end
end