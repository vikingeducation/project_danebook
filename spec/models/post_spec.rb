require 'rails_helper'

describe Post do
  let(:post) { create(:post) }

  describe '#posted_on' do
    it 'should respond to posted on method' do
      expect(post).to respond_to(:posted_on)
    end

    it 'should have a human readable posted on date' do
      expect(post.posted_on).to eq("Posted on #{DateTime.now.strftime("%A %m/%d/%Y")}")
    end
  end

  describe '#has_likes?' do
    it 'should have return false by default' do
      expect(post.has_likes?).to be false
    end

    it 'should return true once the post has likes.' do
      post_like = create(:liked_post)
      post.likes << post_like
      expect(post.has_likes?).to be true
    end
  end

  context 'comment association' do
    it 'should respond to comment association' do
      expect(post).to respond_to(:comments)
    end
  end

  context 'people who like association' do
    it 'should respond to people_who_like association' do
      expect(post).to respond_to(:people_who_like)
    end

    it 'should get an empty result by default' do
      expect(post.people_who_like.count).to eq(0)
    end

    it 'should return results once it has likes' do
      post.likes << create(:liked_post)
      expect(post.people_who_like.count).to eq(1)
    end
  end

  context 'author association' do
    it 'should respond to author association' do
      expect(post).to respond_to(:author)
    end

    it 'should return an author by defualt' do
      expect(post.author).to be_a(User)
    end
  end

  context 'post creation' do
    let(:user) { build(:user) }
    it 'should attribute a post to a user' do
      create(:post, author: user)
      expect(user.written_posts.count).to eq(1)
    end
  end

  context 'commenting on posts' do
    let(:user) { build(:user) }
    let(:new_comment) { build(:commented_post) }
    it 'should allow a user to have comments on posts' do
      user.comments << new_comment
      user.save
      expect(user.comments.count).to eq(1)
    end

    it 'should allow a user to retrieve a post based on the comment' do
      user.comments << new_comment
      user.save
      expect(user.posts_commented_on.first).to eq(new_comment.commentable)
    end
  end

end
