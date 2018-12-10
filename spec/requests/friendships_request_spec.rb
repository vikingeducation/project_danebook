require 'rails_helper'

describe 'UsersRequests' do
  describe 'UserAccess' do

    let(:user) { create(:user) }
    let(:another_user) { create(:user) }

    before :each do
      post session_path, params: { email: user.email, password: user.password }
    end

    describe 'POST #create' do

      it 'actually creates a friendship' do
        expect{ post friendship_path, params: { friendship: { friender_id: user.id,
                                                friendee_id: another_user.id } }
                                              }.to change(Friendship, :count).by(1)
      end

      it 'creates a flash message' do
        expect(flash[:success]).not_to be_nil
      end

    end

    describe 'DELETE #destroy' do
      before :each do
        post friendship_path, params: { friendship: { friender_id: user.id, friendee_id: another_user.id } }
      end

      it 'actually terminates friendship' do
        expect { delete friendship_path, params: { friendship: { friender_id: user.id, friendee_id: another_user.id } }
               }.to change(Friendship, :count).by(-1)
      end

      it 'creates flash message' do
        delete friendship_path, params: { friendship: { friender_id: user.id, friendee_id: another_user.id } }
        expect(flash[:success]).not_to be_nil
      end
    end


  end
end
