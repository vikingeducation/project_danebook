require 'rails_helper'



describe User do

  let(:user) { build(:user) }


  it "not created with a blank password" do
    expect { create(:user, password: "") }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "not created with a too-long password" do
    expect { create(:user, password: "thispasswordisprettysecurebutwaytoolong") }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "not created with a duplicate email address" do
    create(:user, email: user.email)
    expect(build(:user, email: user.email)).to_not be_valid
  end

  it "token is generated around user create" do
    user.save
    expect(user.auth_token).to_not be nil
  end

  it "creating a new user creates a new profile too" do
    user.save
    expect(user.profile).to be_instance_of(Profile)
  end

  it "deleting a user deletes their profile too" do
    user.save
    user.destroy
    expect(user.profile.persisted?).to be false
  end





  describe '#regenerate_auth_token' do

    it "gives the user a new auth token" do
      user.save
      old_token = user.auth_token
      user.regenerate_auth_token
      new_token = user.auth_token
      expect(new_token).to_not eq(old_token)
    end

    it "no users have the old token" do
      user.save
      old_token = user.auth_token
      user.regenerate_auth_token
      expect(User.find_by_auth_token(old_token)).to be nil
    end
  end


end