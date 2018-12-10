module LoginMacros

  def sign_in(user)
    fill_in "email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"
  end


  def sign_out

  end

end
