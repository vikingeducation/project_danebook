require 'rails_helper'

describe Profile do

  let(:profile){build(:profile)}

  context 'associations' do

    it 'responds to user' do
      expect(profile).to respond_to(:user)
    end

    it 'responds to posts' do
      expect(profile).to respond_to(:posts)
    end

  end
end