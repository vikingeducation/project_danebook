require 'rails_helper'

describe FriendRequest do
  it_behaves_like 'Dateable'
  it_behaves_like 'Friendable'
  it_behaves_like 'Notifiable'

  describe '#accept' do
    it 'triggers a after update callback'
    it 'results in a friendship being created when set to true'
    it 'results in no friendship being created if set to false'
  end
end
