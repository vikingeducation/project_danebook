module AuthenticationMacros

  def login(user)
    visit root_url
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_button("Sign In")
  end

end
