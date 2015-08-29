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

=begin
  describe 'PATCH #update' do

    let(:initiator) { create(:user) }
    let(:victim) { create(:user) }

    before do
      initiator
      victim
      request.cookies[:auth_token] = initiator.auth_token
    end


    it 'allows a user to edit his own profile' do
      legit_update = 'Fancy University'
      put :update,  :id => initiator.id,
                    :user => attributes_for(:user,
                             :profile_attributes => { :college => legit_update, :id => initiator.profile.id } )

      initiator.reload
      expect(initiator.profile.college).to eq(legit_update)
      expect(flash[:success]).to eq('Profile updated!')
    end


    it 'rejects when user_id in params is not current_user' do
      malicious_update = 'Loser College'
      put :update,  :id => victim.id,
                    :user => attributes_for(:user,
                             :profile_attributes => { :college => malicious_update, :id => victim.profile.id } )

      victim.reload
      expect(victim.profile.college).not_to eq(malicious_update)
      expect(flash[:danger]).to eq("You're not authorized to do this!")
    end


  end
=end

end