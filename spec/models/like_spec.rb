require 'rails_helper'

describe Like do
  it_behaves_like 'Dateable'
  it_behaves_like 'Feedable'
  it_behaves_like 'Notifiable'

  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:post){create(:post, :user => user)}
  let(:post_like){create(:post_like, :user => user, :likeable => post)}

  describe '#user' do
    it 'returns the user to which this like belongs' do
      # 
      expect(post_like.user).to eq(user)
    end
  end

  describe '#likeable' do
    it 'returns the likeable to which this like belongs' do
      # 
      expect(post_like.likeable).to eq(post)
    end
  end

  describe 'validates' do
    describe 'user' do
      it 'is present' do
        # 
        expect {create(:post_like, :user => nil, :likeable => post)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end