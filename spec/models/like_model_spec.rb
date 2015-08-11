require 'rails_helper'

describe Like do

  let(:like_post){build(:like_post)}
  let(:like_comment){build(:like_comment)}

  context 'associations' do

    it 'should respond to user' do
      expect(like_post).to respond_to(:user)
    end

    it 'should respond to liking' do
      expect(like_comment).to respond_to(:liking)
    end

  end

  context 'method' do

    context 'return liked object' do

      specify 'for a post' do
        like_post.save
        expect(Like.find_liked_object(like_post.liking, like_post.user)).to eq(like_post)
      end

      specify 'for a comment' do
        like_comment.save
        expect(Like.find_liked_object(like_comment.liking, like_comment.user)).to eq(like_comment)
      end

    end
  end
end