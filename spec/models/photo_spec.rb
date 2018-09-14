require 'rails_helper'

RSpec.describe Photo, type: :model do
 describe 'attributes' do

   let(:user){ create(:user) }
   let(:photo){ create(:photo, user_id: user.id) }

   it 'belongs to a user' do
     expect(photo).to belong_to(user)
   end
   it 'is valid with valid attributes'
 end
 describe 'comment associations' do
   it 'responds to comments'
   it 'can successfully link to a valid comment'
 end
 describe 'like associations' do
   it 'responds to likes'
   it ''
 end

end
