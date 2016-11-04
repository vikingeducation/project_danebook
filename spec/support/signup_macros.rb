module SignupMacros
  def signup(options = nil)
    options = options ? default_options.merge(options) : default_options
    visit new_user_path
    fill_in('user_profile_attributes_first_name', with: options[:first_name])
    fill_in('user_profile_attributes_last_name', with: options[:last_name])
    fill_in('user_email', with: options[:email])
    fill_in('user_password', with: options[:password])
    fill_in('user_password_confirmation', with: options[:confirmation])
    select(options[:day], from: 'user_profile_attributes_birthday_3i')
    select(options[:month], from: 'user_profile_attributes_birthday_2i')
    select(options[:year], from: 'user_profile_attributes_birthday_1i')
    click_button('Sign Up!')
  end


  private
  def default_options
    {first_name: 'Morgan',
      last_name: 'Martin', email: 'admin@example.com',
      password: 'password', confirmation: 'password',
      day: '6', month: 'August', year: '1994' }
  end
end
