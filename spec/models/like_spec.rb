require 'rails_helper'

describe Like do
  let(:user) { build(:user) }

  context 'liking posts' do
    let(:post){ create(:post) }

    it 'should allow a user to like a post' do
      new_like = create(:liked_post, likable: post, user: user)
      expect(user.liked_posts.count).to eq(1)
    end

    it 'should not allow a user to like a post more than once' do
      new_like = create(:liked_post, likable: post, user: user)
      new_like2 = build(:liked_post, likable: post, user: user)
      expect(new_like2).to be_invalid
    end

    it 'should allow two random users to like the same post' do
      new_like = create(:liked_post, likable: post)
      new_like2 = build(:liked_post, likable: post)
      expect(new_like2).to be_valid
    end
  end

  context 'liking comments' do
    let(:comment){ create(:comment) }

    it 'should allow a user to like a comment' do
      new_like = create(:liked_comment, likable: comment, user: user)
      expect(user.liked_comments.count).to eq(1)
    end

    it 'should not allow a user to like a comment more than once' do
      new_like = create(:liked_comment, likable: comment, user: user)
      new_like2 = build(:liked_comment, likable: comment, user: user)
      expect(new_like2).to be_invalid
    end

    it 'should allow two random users to like the same comment' do
      new_like = create(:liked_comment, likable: comment)
      new_like2 = build(:liked_comment, likable: comment)
      expect(new_like2).to be_valid
    end
  end
end
