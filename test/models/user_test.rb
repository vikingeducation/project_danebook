require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'should return users whose names contain \'Virtucio\'' do
    users = User.search_by_full_name 'Virtucio'
    assert users.any? { |u| !!(/\AVirtucio\z/.match u.last_name) }
  end

end
