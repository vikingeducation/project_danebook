require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'should match users by their first or last names' do
    users = User.search_by_full_name 'virtucio'
    assert users.any? { |u| !!(/\AVirtucio\z/.match u.last_name) }
    users = User.search_by_full_name 'tester'
    assert users.any? { |u| !!(/\ATester\z/.match u.first_name) }
  end

  test 'should match similar names' do
    VARIANTS = { plural: User.search_by_full_name('virtucios'),
      possessive: User.search_by_full_name('virtucio\'s'),
      past_tense: User.search_by_full_name('virtucioed') }
    assert VARIANTS.all? do |v|
      v.any? { |u| !!(/\AVirtucio\z/.match u.last_name) }
    end
  end

  test 'should set reset_digest attribute of User instance' do
    user = users :test_user
    user.make_reset_digest
    assert user.reset_token
    assert user.reset_digest
  end

end
