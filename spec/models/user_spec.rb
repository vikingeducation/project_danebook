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

  it "requires a unique email" do
    a = build(:user, email: "special@snowflake.com")
    a.save
    b = build(:user, email: "special@snowflake.com")
    expect(b).not_to be_valid
  end

  it "is capable of friendship" do
    expect(user).to respond_to(:friended_users)
  end

  it "can make friends" do
    bob = build(:user)
    bob.save
    larry = build(:user)
    larry.save
    bob.friended_users << larry
    expect(bob.friended_users).to include(larry)
  end

  it "cannot be double-friends" do
    bob = build(:user)
    bob.save
    larry = build(:user)
    larry.save
    bob.friended_users << larry
    expect { bob.friended_users << larry }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "is not oblivious to friendship" do
    bob = build(:user)
    bob.save
    larry = build(:user)
    larry.save
    bob.friended_users << larry
    expect(larry.users_friended_by).to include(bob)
  end

end
