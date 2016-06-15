require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'should match users by their first or last names' do
    users = User.search_by_full_name 'virtucio'
    assert users.any? { |u| !!(/\AVirtucio\z/.match u.last_name) }
    users = User.search_by_full_name 'tester'
    assert users.any? { |u| !!(/\ATester\z/.match u.first_name) }
  end

end
