require 'rails_helper'

describe Activity do
  let(:activity){ build(:activity)}
  let(:user){ create(:user, :with_friends)}
  context 'instance methods' do
    describe '#to_text' do
      it 'returns the correct string' do
        expect(build(:activity, :for_post).to_text).to eq('Created a post')
        expect(build(:activity, activable: build(:comment, :for_post)).to_text).to eq('Wrote a comment')
        expect(build(:activity, :for_photo).to_text).to eq('Uploaded a photo')
        expect(build(:activity, activable: build(:like, :for_post)).to_text).to eq('Liked a post')
      end
    end
  end
  context 'class methods' do
    describe 'recently_active' do
      it 'does not throw an error if argument missing' do
        expect{Activity.recently_active}.not_to raise_error
      end
      it 'returns activities in reverse chronological order' do
        user.friendees.each do |f|
          create(:activity, :for_post, user: f)
        end
        expect(Activity.recently_active(user).first.created_at).to be > (Activity.recently_active(user).last.created_at)
      end
    end
    describe 'newsfeed' do
      it 'does not throw error if argument missing' do
        expect{ Activity.newsfeed}.not_to raise_error
      end
      it 'returns posts in reverse chronological order' do
        user.friendees.each do |f|
          create(:activity, :for_post, user: f)
        end
        expect(Activity.newsfeed(user).first.created_at).to be > (Activity.recently_active(user).last.created_at)
      end
    end
  end

end
