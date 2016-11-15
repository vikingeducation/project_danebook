require 'rails_helper'

describe Dateable do
  let(:female){create(:female)}
  let(:user){create(:user, :gender => female)}

  describe '#date' do
    it 'returns a formatted date string for the created_at timestamp of the model' do
      expect(user.profile.date).to eq(user.created_at.strftime("%A, %B #{user.created_at.day.ordinalize} %Y"))
    end
  end
end

