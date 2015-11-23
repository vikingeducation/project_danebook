require 'rails_helper'

describe 'Users' do
  let!(:male){create(:male)}
  let!(:female){create(:female)}
  let(:user){build(:user, :gender => female)}
  let(:invalid){build(:user, :gender => female, :email => '')}

  before do
    visit signup_path
  end

  describe 'signup' do
    it 'informs the user they are signed in after successful signup' do
      signup(user)
      expect(page).to have_content('User created and signed in')
    end

    it 'informs the user when signup went wrong' do
      signup(invalid)
      expect(page).to have_content('Unable to create user')
    end
  end
end