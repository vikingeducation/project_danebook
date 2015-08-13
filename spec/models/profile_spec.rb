require 'rails_helper'

describe Profile do
  let(:profile){build(:profile)}

  it "should show who it belongs to" do
    expect(profile).to respond_to(:user)
  end

  it "has a college" do
    expect(profile.college).to eq("foo")
  end

  it "has a telephone" do
    expect(profile.telephone).to eq("8888888")
  end

  it "has a hometown" do
    expect(profile.hometown).to eq("barville")
  end

  it "has a current location" do
    expect(profile.current_location).to eq("bar")
  end

  it "has a about me" do
    expect(profile.about_me).to eq("foo")
  end

  it "has words to live by" do
    expect(profile.words_to_live_by).to eq("bar")
  end


end