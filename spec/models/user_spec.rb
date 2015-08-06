require 'rails_helper'
require 'support/factory_girl'

describe User do

  let(:user){build(:user)}

  it "with all fields completed is valid" do
    expect(user).to be_valid
  end

  it "saves without error" do
    expect{user.save!}.to_not raise_error
  end

  it "will fail without an email" do
    user = build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it "will fail without a unique email" do
    user = build(:user, email: "foo@bar.com")
    user.save

    new_user = build(:user, first_name: "foo", last_name: "bar",
                      email: "foo@bar.com", password: "password",
                      password_confirmation: "password",
                      birthdate: Date.parse('20-10-2000') )

    expect(new_user).to_not be_valid

  end

  it "will fail if email input doesn't have '@'" do
    user = build(:user, email: "foo.bar.com")
    expect(user).to_not be_valid
  end

  it "will fail without a first name" do
    user = build(:user, first_name: nil)
    expect(user).to_not be_valid
  end

  it "has a first name between 1 and 30 characters" do
    user = build(:user, first_name: "")
    expect(user).to_not be_valid

    user = build(:user, first_name: "A")
    expect(user).to be_valid

    str= "foobarbaz"*4
    user = build(:user, first_name: str)
    expect(user).to_not be_valid

    str= "foobarbaz"*3
    user = build(:user, first_name: str)
    expect(user).to be_valid
  end

  it "will fail if first_name has no letters" do
    user = build(:user, first_name: "  ")
    expect(user).to_not be_valid

    user = build(:user, first_name: "1238")
    expect(user).to_not be_valid
  end

  it "will fail without a last name" do
    user = build(:user, last_name: nil)
    expect(user).to_not be_valid
  end

  it "has a last name between 1 and 30 characters" do
    user = build(:user, last_name: "")
    expect(user).to_not be_valid

    user = build(:user, last_name: "A")
    expect(user).to be_valid

    str= "foobarbaz"*4
    user = build(:user, last_name: str)
    expect(user).to_not be_valid

    str= "foobarbaz"*3
    user = build(:user, last_name: str)
    expect(user).to be_valid
  end

  it "will fail if last_name has no letters" do
    user = build(:user, last_name: "  ")
    expect(user).to_not be_valid

    user = build(:user, last_name: "1238")
    expect(user).to_not be_valid
  end

  xit "password length should be between 6 and 16 characters" do
    user = build(:user, password: "32", password_confirmation: "32")
    expect(user).to_not be_valid

    user = build(:user, password: "111111111111111111", password_confirmation: "111111111111111111")
    expect(user).to_not be_valid

  end

  xit "should have matching password and password confirmation" do
    user = build(:user, password: "password", password_confirmation: "password1")

    expect(user).to_not be_valid
  end

  xit "should respond to full_nam method" do
    expect{user.full_name}.to_not raise_error
  end





end