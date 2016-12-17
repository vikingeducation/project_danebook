require 'rails_helper'

describe User do

  let(:user) { create(:user) }

  it "generates an auth token before creation of a user"

  it "can output the user's full name" do
    expect(user.full_name).to eq("Bob Dobbs")
  end

  it "has one profile" do
    should have_one(:profile)
  end

  it "has many authored posts" do
    should have_many(:authored_posts)
  end

  it "has many liked things" do
    should have_many(:liked_things)
  end

  it "accepts nested attributes for profile" do
    should accept_nested_attributes_for(:profile)
  end

  it "accepts nested attributes for authored posts" do
    should accept_nested_attributes_for(:authored_posts)
  end

  it "requires the presence of all attributes before admitting into the database"

  it "validates its attributes' lengths before admitting into the database"

end