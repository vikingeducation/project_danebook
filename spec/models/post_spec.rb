require 'rails_helper'

describe Post do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:profile){create(:profile, :user => user)}
  let(:post){create(:post, :user => user)}
  let(:post_comments){create_list(:post_comment, 2, :user => user, :commentable => post)}
  let(:post_likes){create_list(:post_like, 2, :user => user, :likeable => post)}

  describe '#user' do
    it 'returns the user that authored this post' do
      expect(post.user).to eq(user)
    end
  end

  describe '#comments' do
    it 'returns the comments that belong to this post' do
      post_comments
      expect(post.comments).to eq(post_comments)
    end
  end

  describe '#likes' do
    it 'returns the likes that belong to this post' do
      expect(post.likes).to eq(post_likes)
    end
  end

  describe 'validates' do
    describe 'body' do
      it 'is present' do
        expect {create(:post, :user => user, :body => '')}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe 'user' do
      it 'is present' do
        expect {create(:post, :user => nil)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '#destroy' do
    before do
      post.destroy!
    end

    it 'destroys all the comments that belong to this post' do
      expect(Comment.where(:commentable_id => post.id, :commentable_type => post.class.name)).to be_empty
    end

    it 'destroys all the likes that belong to this post' do
      expect(Like.where(:likeable_id => post.id, :likeable_type => post.class.name)).to be_empty
    end
  end
end






