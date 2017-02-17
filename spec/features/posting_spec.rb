require 'rails_helper'

feature "Posting" do

  let(:user) { create(:user) }
  let(:profile) { build(:profile) }

  before do
    visit root_path
    login(user)
    user.profile = profile
  end

  context "post" do

    it "allows a user to post from his timeline" do
      expect{ create_post("THIS IS A POST") }.to change(Post, :count).by(1)
    end

  end

  context "unpost" do

    it "allows a user to delete his/her own post" do
      create_post("THIS IS A POST")
      expect{ click_on("Delete") }.to change(Post, :count).by(-1)
    end

  end

end