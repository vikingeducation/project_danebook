require 'rails_helper'

describe User do
  let(:user){build(:user)}

  it "should be valid with default attributes" do
    expect(user).to be_valid
  end

  it "saves with default attributes" do
    expect{ user.save! }.to_not raise_error
  end

  it "does not allow a password less than 6 characters" do
    user.password = "l" * 5
    expect(user).not_to be_valid
  end

  it "does allow a password 6 characters" do
    user.password = "l" * 6
    expect(user).to be_valid
  end

  it "does not allow a password more than 15 characters" do
    user.password = "l" * 16
    expect(user).not_to be_valid
  end

  it "does allow a password 15 characters" do
    user.password = "l" * 15
    expect(user).to be_valid
  end

  it "does not allow a first_name less than 2 characters" do
    user.first_name = "l" * 1
    expect(user).not_to be_valid
  end

  it "does allow a first_name 2 characters" do
    user.first_name = "l" * 2
    expect(user).to be_valid
  end

  it "does not allow a first_name more than 20 characters" do
    user.first_name = "l" * 21
    expect(user).not_to be_valid
  end

  it "does allow a first_name 20 characters" do
    user.first_name = "l" * 20
    expect(user).to be_valid
  end

  it "does not allow a last_name less than 2 characters" do
    user.last_name = "l" * 1
    expect(user).not_to be_valid
  end

  it "does allow a last_name 2 characters" do
    user.last_name = "l" * 2
    expect(user).to be_valid
  end

  it "does not allow a last_name more than 20 characters" do
    user.last_name = "l" * 21
    expect(user).not_to be_valid
  end

  it "does allow a last_name 20 characters" do
    user.last_name = "l" * 20
    expect(user).to be_valid
  end

  context "when saving multiple users" do
    before do
      user.save!
    end
    it "doesn't allow identical email addresses" do
      new_user = build(:user, :email => user.email)
      expect(new_user).not_to be_valid
    end

  end

  it "responds to the posts association" do
    expect(user).to respond_to(:profile)
  end

  it "responds to the posts association" do
    expect(user).to respond_to(:posts)
  end

  it "responds to the posts association" do
    expect(user).to respond_to(:comments)
  end

  describe "#full_name" do

    it "returns the first and last name combined" do
      expect(user.full_name).to eq(user.first_name + " " + user.last_name)
    end
  end


  # it "should not be valid without a first name" do
  #   user.first_name = ""
  #   expect(user).to_not be_valid
  # end

  # it "should not be valid without a last name" do
  #   user.last_name = ""
  #   expect(user).to_not be_valid
  # end

  # it "should not be valid without an email address" do
  #   user.email = ""
  #   expect(user).to_not be_valid
  # end

  # it "should not be valid without a gender" do
  #   user.gender = ""
  #   expect(user).to_not be_valid
  # end

  # it "should not be valid without a birthday"  do
  #   user.birthday = ""
  #   expect(user).to_not be_valid
  # end

  # it "should be able to call a profile" do
  #   expect(user).to respond_to(:profile)
  # end

end