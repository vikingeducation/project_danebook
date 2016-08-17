require 'rails_helper'
describe Like do
  let( :comment_like ) { build(:comment_like) }
  let( :post_like ) { build(:post_like) }

  it { should validate_uniqueness_of(:user_id).scoped_to(:likeable_id)}
  describe 'associations' do
    it { should belong_to(:likeable) }
    it { should belong_to(:user) }
  end

  describe 'polymorphic associations' do
    it "should have the parent comment respond to likes" do
      expect(comment_like.likeable).to respond_to(:likes)
    end
    it "should have the parent post respond to likes" do
      expect(post_like.likeable).to respond_to(:likes)
    end
  end
end
