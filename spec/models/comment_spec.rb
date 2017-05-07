require 'rails_helper'

describe Comment do
  let(:comment){ create(:comment, :for_post)}
  let(:like){ create(:comment_like, comment: comment)}
  let(:user){ create(:user, :with_profile)}
  let(:friend){ build(:user ,:with_profile)}
  let(:posting){ create(:post, user: user)}
  context 'validations' do
    it 'is invalid without body' do
      comment.body = nil
      expect(comment).to be_invalid
    end
    it 'is invalid without user' do
      comment.user = nil
      expect(comment).to be_invalid
    end
  end
  it 'likes count is zero by default' do
    expect(comment.likes_count).to eq(0)
  end

  context '#liked_by?' do
    it 'correctly tells us if comment is liked by a user' do
      user = create(:user, id: 77)
      like = create(:like, user_id: 77, likeable: comment)
      comment.likes << like
      expect(comment.liked_by?(like.user)).to eq(true)
      expect(comment.liked_by?(build(:user))).to eq(false)
    end
  end
  context 'associations' do
    it 'responds to comment_likes' do
      expect(comment).to respond_to(:likes)
    end
  end
  describe 'notification emails' do
    context 'delayed emails on' do
      before do
        Rails.application.secrets.use_delayed_emails = 'true'
        posting
        friend
      end
      it 'queues a notification email if comment created by friend' do
        expect{create(:comment, user: friend, commentable: posting)}.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :count).by(1)
      end
      it 'does not queue a notification email if comment created by self' do
        expect{ create(:comment, user: user, commentable: posting)}.not_to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :count)
      end
    end
  end
  context 'delayed emails off' do
    before do
      Rails.application.secrets.use_delayed_emails = nil
      posting
      friend
    end
    it 'sends a notification email if comment created by friend' do
      expect{create(:comment, user: friend, commentable: posting)}.to change(ActionMailer::Base.deliveries, :count).by(1)
    end
    it 'does not send a notification email if comment created by self' do
      expect{ create(:comment, user: user, commentable: posting)}.not_to change(ActionMailer::Base.deliveries, :count)
    end
  end

end
