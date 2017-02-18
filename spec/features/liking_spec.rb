require 'rails_helper'

feature "Liking" do

  let(:bob) { create(:user) }
  let(:profile) { build(:profile) }

  before do
    bob.profile = profile
    visit root_path
    login(bob)
    create_post("THIS BE A POST")
  end

  context "like" do

    it "allows a user to like a post" do
      expect{ click_on "Like" }.to change(Like, :count).by(1)
    end

    it "allows a user to like a comment" do
      create_comment("THIS BE COMMENT")
      within(".comment-body") do
        expect{click_on "Like"}.to change(Like, :count).by(1)
      end
    end

  end

  context "unlike" do

    before do
      click_on "Like"
    end

    it "allows a user to unlike a post" do
      expect{click_on "Unlike"}.to change(Like, :count).by(-1)
    end

    it "allows a user to unlike a comment" do
      create_comment("THIS BE COMMENT")
      within(".comment-body") do
        click_on "Like"
      end
      within(".comment-body") do
        expect{click_on "Unlike"}.to change(Like, :count).by(-1)
      end
    end

  end

end