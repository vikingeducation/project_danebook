module Macros
  module User
    def signup(user)
      fill_in('user_first_name', :with => user.first_name)
      fill_in('user_last_name', :with => user.last_name)
      fill_in('user_email', :with => user.email)
      fill_in('user_password', :with => user.password)
      fill_in('user_password_confirm', :with => user.password)
      page.select('1', :from => 'user_birthday_3i')
      page.select('January', :from => 'user_birthday_2i')
      page.select('2015', :from => 'user_birthday_1i')
      choose('user_gender_id_2')
      find('input[value="Sign Up!"]').click
    end
  end
end