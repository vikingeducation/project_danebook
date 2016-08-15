require 'rails_helper'

describe Profile do
  let(:profile) { build(:profile) }

  it "has a first name" do
    expect(profile).to respond_to(:first_name)
  end

  it "has a last name" do
    expect(profile).to respond_to(:last_name)
  end

  it "has words from the user" do
    expect(profile).to respond_to(:words)
  end

  it "has words about the user" do
    expect(profile).to respond_to(:about)
  end

  it "has a college" do
    expect(profile).to respond_to(:college)
  end

end