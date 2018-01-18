module AuthenticationMacros

  def login(user)
    visit root_url
    fill_in('Email', with: user.email)
    fill_in('Password', with: 'password')
    click_button("Log in")
  end

end
