module LoginMacros
  def login(user)
    visit root_path
    page.all(:fillable_field, 'Email')[0].set(user.email)
    page.all(:fillable_field, 'Password')[0].set(user.password)
    click_button("Log in")
  end
end
