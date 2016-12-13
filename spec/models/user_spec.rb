require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it "is valid with default attributes" do
    expect(user).to be_valid
  end

  it "is valid with a standard password size" do
    expect(build(:user, password: "1234567890")).to be_valid
  end

  it "is not valid when the password is too short" do
    expect(build(:user, password: "")).not_to be_valid
  end

  # it "is capable of friendship" do
  #   expect(user).to respond_to(:friends)
  # end

end
