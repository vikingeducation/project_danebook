module Macros
  module Session
    def sign_in(user)
      page.find('#email').set(user.email)
      page.find('#password').set(user.password)
      find('input[value="Sign In"]').click
    end

    def sign_out
      visit logout_path
    end
  end
end