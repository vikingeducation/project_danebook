require 'rails_helper'

describe User do
  let(:user){ build(:user)}
  let(:full_user){ build(:user, :with_profile)}
  it 'is valid with default attributes' do
    expect(user).to be_valid
  end
  it 'saves with default attributes' do
    expect{user.save}.not_to raise_error
  end
  it 'is invalid without email' do
    user.email = nil
    expect(user).to be_invalid
  end
  it 'is invalid without password' do
    user.password = nil
    expect(user).to be_invalid
  end
  it 'is invalid if email is fewer than 6 chars' do
    user.email = 'xxx'
    expect(user).to be_invalid
  end
  it 'is invalid if password password is fewer than 12 chars' do
    user.password = 'xxx'
    expect(user).to be_invalid
  end
  it 'does not allow duplicate emails' do
    u = create(:user, email: 'a@a.com')
    copycat = build(:user, email: 'a@a.com')
    expect(copycat).to be_invalid
  end
  it 'is invalid without first or last name' do
    expect(build(:user, first_name: nil)).to be_invalid
    expect(build(:user, last_name: nil)).to be_invalid
    expect(build(:user, first_name: nil, last_name: nil)).to be_invalid
  end

  describe 'class methods' do
    describe 'search' do
      it 'returns the correct search results' do
        create(:user, first_name: 'afa')
        create(:user, first_name: 'faa')
        create(:user, last_name: 'aaf')
        expect(User.search('f').count).to eq(3)
        expect(User.search('g').count).to eq(0)
      end
    end
  end

  describe 'instance methods' do
    let(:user){ create(:user, :with_profile)}
    let(:friend){ create(:user, :with_profile)}
    def add_friend(user, friend)
      user.friendees << friend
    end
    def add_rejected_friend(user, friend)
      user.friendees << friend
      f = Friendship.last.update(rejected: true)
    end
    describe '#full_name' do
      it 'returns a user\'s full name' do
        expect(user.full_name).to eq(user.first_name + ' ' + user.last_name)
      end
    end

    describe '#friendship_status' do
      it 'returns "create" if user not logged in' do
        expect(friend.friendship_status(user)).to eq('create')
      end
      context 'logged in' do
        before do
          login_as(user, user: :user)
        end
        it 'returns nil if request not accepted' do
          create(:friendship, friender_id: user.id, friendee_id: friend.id, rejected: nil)
          expect(friend.friendship_status(user)).to be_nil
        end
        it 'returns true if request rejected' do
          create(:friendship, friender_id: user.id, friendee_id: friend.id, rejected: true)
          expect(friend.friendship_status(user)).to eq(true)
        end
        it 'returns friends if request accepted' do
          user = create(:user, :with_accepted_friend_request)
          friend = user.friendees.last
          expect(friend.friendship_status(user)).to eq(false)
        end
        it "returns 'create' if no friendship record" do
          expect(friend.friendship_status(user)).to eq('create')
        end
      end
    end
  end

  context 'associations' do
    it 'responds to posts associations' do
      expect(user).to respond_to(:posts)
    end
    it 'responses to likes associations' do
      expect(user).to respond_to(:likes)
    end
    it 'responeds to comments associations' do
      expect(user).to respond_to(:comments)
    end
    it 'responds to comment_likes associations' do
      expect(user).to respond_to (:comment_likes)
    end
    it 'responds to initiated_friendships' do
      expect(user).to respond_to (:initiated_friendships)
    end
  end

  describe 'emails' do
    let(:queue){ ActiveJob::Base.queue_adapter.enqueued_jobs }
    context 'delayed emails on' do
      before do
        Rails.application.secrets.use_delayed_emails = 'true'
      end
      it 'queues a welcome email on creation' do
        expect{ create(:user, :with_profile, :with_welcome_email)}.to change(queue, :count).by(1)
      end
    end
    context 'immediate email notification' do
      before do
        Rails.application.secrets.use_delayed_emails = nil
      end
      it 'sends a welcome email on creation' do
        expect{ create(:user, :with_profile, :with_welcome_email)}.to change(ActionMailer::Base.deliveries, :count).by(1)
      end
    end
  end





end
