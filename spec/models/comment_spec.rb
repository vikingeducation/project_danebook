require 'rails_helper'

describe Comment do
  it_behaves_like 'Dateable'
  it_behaves_like 'Feedable'
  it_behaves_like 'Notifiable'

  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:post){create(:post, :user => user)}
  let(:post_comment){create(:post_comment, :user => user, :commentable => post)}
  let(:comment_likes){create_list(:comment_like, 2, :user => user, :likeable => post_comment)}

  describe '#user' do
    it 'returns the user who made the comment' do
      expect(post_comment.user).to eq(user)
    end
  end

  describe '#commentable' do
    it 'returns the model instance to which this comment belongs' do
      expect(post_comment.commentable).to eq(post)
    end
  end

  describe '#likes' do
    it 'returns the likes that belong to this comment' do
      expect(post_comment.likes).to eq(comment_likes)
    end
  end

  describe 'validates' do
    describe 'body' do
      it 'is present' do
        expect {create(:post_comment, :body => '', :user => user, :commentable => post)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe 'user' do
      it 'is present' do
        expect {create(:post_comment, :user => nil, :commentable => post)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '#destroy' do
    before do
      post_comment.destroy!
    end

    it 'destroys all the likes associated with this comment' do
      expect(Like.where(:likeable_id => post_comment.id, :likeable_type => post_comment.class.name)).to be_empty
    end
  end
end
