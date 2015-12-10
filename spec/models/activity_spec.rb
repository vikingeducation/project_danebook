require 'rails_helper'

describe Activity do
  it_behaves_like 'Dateable'

  describe '#user' do
    it 'returns the user to which this activity belongs'
  end

  describe '#feedable' do
    it 'returns the feedable to which this activity belongs'
  end

  describe '#feed_for' do
    it 'returns all activities for the given user and friends'
  end

  describe '#timeline_for' do
    it 'returns all activities for just the given user'
  end
end

