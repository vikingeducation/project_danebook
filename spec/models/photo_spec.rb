require 'rails_helper'

describe Photo do
  let(:photo){ create(:photo) }

  context "associations" do
    it "belongs to a user" do
      expect{photo.user}.not_to raise_error
    end

    it "has many comments" do
      expect{photo.comments}.not_to raise_error
    end

    it "has many likes" do
      expect{photo.likes}.not_to raise_error
    end
  end

end
