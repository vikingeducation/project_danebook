module LoginMacros

  def sign_in(user)
    visit root_path
    fill_in "Email", with: user.email
    within("form[role='login']") do
      fill_in "Password", with: "adahnadahn"
    end
    click_button "Login"
  end

  def sign_out
    visit root_path
    click_link "Log Out"
  end

end