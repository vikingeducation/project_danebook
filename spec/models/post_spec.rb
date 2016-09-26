require 'rails_helper'

describe Post do
  let(:post){build(:post)}

  describe 'validations' do
    it "invalid if description is nil/empty" do
      new_user = build(:post, :description => nil)
      expect(new_user.valid?).to eq(false)
    end
  end

  describe 'associations' do
    it "responds to user association" do
      expect(post).to respond_to(:user)
    end

    it "responds to comment association" do
      expect(post).to respond_to(:comments)
    end

    it "responds to likes association" do
      expect(post).to respond_to(:likes)
    end
  end
end