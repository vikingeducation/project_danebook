require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'should return users whose names contain \'Virtucio\'' do
    users = User.search_by_full_name 'Virtucio'
    assert_equal 'Virtucio', users.first.last_name
  end
  
end
