require 'rails_helper'

describe Like do
  let(:like){ build(:like) }

  it "is valid out of the gate" do
    expect(like).to be_valid
  end

  describe "validations" do
    context "repititions" do
      it "does not allow multiple likes" do
        new_like = build(:like, :user_id => like.user_id, :post_id => like.post_id)
        expect(new_like).not_to be_valid
      end
    end
  end

  describe "associations" do
    context "associating with other objects" do
      it "responds to the liker association" do
        expect(like).to respond_to(liker)
      end
      it "responds to the parent post" do
        expect(like).to respond_to(parent_post)
      end
    end
  end
end