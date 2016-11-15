require 'rails_helper'

describe 'Friendships' do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:friend){create(:user, :gender => male)}
  let(:friend_request){create(:friend_request, :initiator => friend, :approver => user)}

  before do
    friend_request.accept
    visit login_path
    sign_in(user)
    visit user_friendships_path(user)
  end

  describe 'listing' do
    it 'displays all friendships' do
      expect(page).to have_content(friend.name)
    end
  end

  describe 'unfriending' do
    it 'destroys the friendship' do
      click_link('- Unfriend')
      expect(page).to_not have_content(friend.name)
    end
  end
end