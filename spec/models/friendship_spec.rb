require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  describe "Validations" do

  end

  describe "Associations" do
    it "has many friendeds" do
      is_expected.to have_many :friendeds
    end

    it "has many frienders" do
      is_expected.to have_many :frienders
    end
  end

end
