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

  xit "generate_token gets called before user create" do
    create(:user)
    expect(user).to receive(:generate_token)
  end

  it "generate_token creates a different token"
  it "regenerate_auth_token invalidates old token"
  it "regenerate_auth_token creates a different new token"
  it "creating a new user creates a new profile too"
  it "deleting a user deletes their profile too"




end