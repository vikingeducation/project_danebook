require 'rails_helper'

describe Searchable do
  let(:female){create(:female)}
  let(:user){create(:user, :gender => female)}
  let(:friend){create(:user, :gender => female)}

  describe '#search' do
    it 'searches with a specified scope' do
      expect(User.search(user.name).first).to eq(user)
    end
  end
end

