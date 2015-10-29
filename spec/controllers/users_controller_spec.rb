require 'rails_helper'


describe UsersController do

  describe 'POST #create' do

    it 'should call User.send_welcome_email(@user.id)' do
      test_id = create(:user).id + 1

      # ignore delay
      allow(User).to receive(:delay).and_return(User)

      allow(User).to receive(:send_welcome_email).and_return(true)
      expect(User).to receive(:send_welcome_email).with(test_id)
      post :create, :user => attributes_for(:user)
    end

  end


end