require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  it "validates the presence of an email address" do
    should validate_presence_of(:email)
  end

  it "validates the presence of a password" do
    should validate_presence_of(:password)
  end

  it "has a secure password" do
    is_expected.to have_secure_password
  end

  it "has a profile" do
    expect(user).to respond_to(:profile)
  end

  it "has friends" do
    expect(user).to respond_to(:friends)
  end

  it "belongs to a friendable" do
    expect(user).to respond_to(:friendable)
  end

  it "belongs to a timeline" do
    expect(user).to respond_to(:timeline)
  end

  it "has a first name" do
    expect(user).to respond_to(:first_name)
  end

  it "has a last name" do
    expect(user).to respond_to(:last_name)
  end

  it "can show its full name" do
    first_name = user.first_name
    last_name = user.last_name
    full_name = "#{first_name} #{last_name}"
    expect(user.full_name).to eq(full_name)
  end

end