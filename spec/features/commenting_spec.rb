require 'rails_helper'

feature "Commenting" do

  let(:bob) { create(:user) }
  let(:profile) { build(:profile) }

  before do
      bob.profile = profile
      visit root_path
      login(bob)
      create_post("THIS BE A POST")
    end

  context "comment" do

    it "creates a comment on a post on a given user's timeline" do
      expect{create_comment("THIS BE A COMMENT")}.to change(Comment, :count).by(1)
    end

    it "disallows submitting an empty comment" do
      expect{create_comment("")}.to change(Comment, :count).by(0)
    end

  end

  context "uncomment" do

    it "allows the author to destroy his/her comment" do
      create_comment("THIS BE A COMMENT")
      within(".comment-body") do
        expect{click_on "Delete"}.to change(Comment, :count).by(-1)
      end
    end

  end

end