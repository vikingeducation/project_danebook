require 'rails_helper'

describe Friendship do
  it_behaves_like 'Dateable'
  it_behaves_like 'Friendable'
  it_behaves_like 'Feedable'
  it_behaves_like 'Notifiable'

  describe '#create' do
    context 'there is an existing approved friend request' do
      it 'creates a friendship'
      it 'destroys the friend request'
      it 'creates an activity for each friend'
    end

    context 'there is not an existing approved friend request' do
      it 'does not create a friendship'
      it 'does not destroy the friend request'
      it 'does not create any activities'
    end
  end
end

