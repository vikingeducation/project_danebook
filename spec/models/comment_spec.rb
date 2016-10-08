require 'rails_helper'

describe Comment, type: :model do
  let(:user) {create(:user)}
  let(:text_post){ user.text_posts.create(description: "blah1") }
  let(:comment) { text_post.comments.create(description: "blah") }

  context "validations" do
    it 'with a valid description is validd' do
      text_post = user.text_posts.create(description: "blah1")
      expect(text_post.comments.create(description: "valid", user_id: user.id)).to be_valid
    end

    it 'without a first name is invalid' do
      new_comment = build(:comment, description: nil)
      expect(new_comment).not_to be_valid
    end

    it { should validate_presence_of(:user) }

    it { should validate_presence_of(:commentable) }
  end

  context "comment attribute validations reject unwanted entries" do
    subject{comment}

    it { validate_length_of(:description).is_at_least(1).is_at_most(500) }
  end

  context "comment should be able to be added to post" do
    subject{comment}

    it { is_expected.to belong_to(:commentable) }

    it { is_expected.to belong_to(:user) }

    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:commenters) }

    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:likers) }

  end

end
