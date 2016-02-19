module Macros
  module Login

    def sign_in(user)
      visit signup_path
      within("#top-navbar") do
        fill_in 'email', with: user.email
        fill_in 'password', with: user.password
        click_on 'Login'
      end
    end

    def sign_out
      within("#top-navbar") do
        click_on 'Legout'
      end
    end

  end
end
