require 'rails_helper'
describe Comment do
  let(:comment){ build(:comment) }
  let(:liked_comment){ build(:comment, :liked) }
  describe 'attributes' do
  end
  describe 'associations' do
    it { should belong_to(:commentable) }
    it { should belong_to(:author) }
    it { should have_many(:likes) }
  end
  context "when the comment is liked" do
    it "should have likes" do
      expect(liked_comment.likes.length).to eq(1)
    end
  end
end
