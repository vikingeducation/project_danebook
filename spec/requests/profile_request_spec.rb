require 'rails_helper'

describe 'ProfilesRequests' do

  let(:user){create(:user)}
  let(:profile){create(:profile, :user_id => user.id)}

  before do
    user
    profile
    login_as(user)
  end


  describe "PATCH #update" do

    let(:new_hometown){"Ludwikow"}
    let(:invalid_hometown){"e"}

    context "with valid attributes" do
      it "updates user profile - hometown name" do
        patch user_path(user), params: { :user => attributes_for(:user, {:profile_attributes => attributes_for(:profile, :hometown => new_hometown )} )}
        user.reload

        expect(user.profile.hometown).to eq(new_hometown)
      end
    end

    context "with invalid attributes" do
      it "updates user profile" do
        patch user_path(user), params: { :user => attributes_for(:user, {:profile_attributes => attributes_for(:profile, :hometown => invalid_hometown )} )}
        user.reload
        expect(flash[:success]).to_not be_nil
      end
    end

  end

end
