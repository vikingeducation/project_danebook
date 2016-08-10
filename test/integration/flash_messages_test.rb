require 'test_helper'

class FlashMessagesTest < ActionDispatch::IntegrationTest

  test 'should have a success flash in the view' do
    post users_path user: { first_name: 'Foobar',
                            last_name: 'Barbaz', 
                            email: 'foobar@barbaz.com',
                            password: 'foobar',
                            password_confirmation: 'foobar' }
    assert_redirected_to root_url
    assert flash?('info')
  end

end
