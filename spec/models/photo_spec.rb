require 'rails_helper'

RSpec.describe Photo, type: :model do

  let(:user){ create(:user) }
  let(:photo){ create(:photo, user_id: user.id) }

 describe 'attributes' do

   it 'belongs to a user' do
     expect(photo.user).to eq(user)
   end
   it 'is valid with valid attributes' do
     expect(photo).to be_valid
   end

 end
 describe 'comment associations' do

   it 'responds to comments' do
     expect(photo).to respond_to(:comments)
   end

 end
 describe 'like associations' do

   it 'responds to likes' do
     expect(photo).to respond_to(:likes)
   end

   it 'responds to user likes' do
     expect(photo).to respond_to(:user_likes)
   end

 end

end
