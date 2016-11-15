require 'rails_helper'

describe User do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:profile){user.profile}
  let(:posts){create_list(:post, 2, :user => user)}
  let(:post_comments){create_list(:post_comment, 2, :user => user, :commentable => posts.first)}
  let(:post_like){create(:post_like, :user => user, :likeable => posts.first)}
  let(:comment_like){create(:comment_like, :user => user, :likeable => post_comments.first)}
  let(:profile_photo){create(:profile_photo, :user => user)}
  let(:cover_photo){create(:cover_photo, :user => user)}
  let(:friend){create(:user, :gender => male)}
  let(:friend_request_to_user){create(:friend_request, :initiator => friend, :approver => user)}
  let(:friend_request_from_user){create(:friend_request, :initiator => user, :approver => friend)}

  before do
    user
  end

  # ----------------------------------------
  # Associations
  # ----------------------------------------

  describe '#profile' do
    it 'returns the profile that belongs to this user' do
      expect(profile.user_id).to eq(user.id)
    end
  end

  describe '#profile_photo' do
    it 'returns the profile photo for this user' do
      user.update!(:profile_photo => profile_photo)
      expect(user.profile_photo).to eq(profile_photo)
    end
  end

  describe '#cover_photo' do
    it 'returns the cover photo for this user' do
      user.update!(:cover_photo => cover_photo)
      expect(user.cover_photo).to eq(cover_photo)
    end
  end

  describe '#gender' do
    it 'returns the gender to which this user belongs' do
      expect(user.gender.id).to eq(male.id)
    end
  end

  describe '#posts' do
    it 'returns all of the posts that belong to this user' do
      expect(user.posts).to eq(posts)
    end
  end

  describe '#comments' do
    it 'returns all the comments that belong to this user' do
      expect(user.comments).to eq(post_comments)
    end
  end

  describe '#likes' do
    it 'returns all the likes that belong to this user' do
      expect(user.likes).to eq([post_like, comment_like])
    end
  end

  describe '#photos' do
    it 'returns all photos for this user' do
      user.update!(:profile_photo => profile_photo)
      expect(user.photos).to eq(Photo.where(:user_id => user.id))
    end
  end

  describe '#requested_friendships' do
    it 'returns the friendships where this user was the initiator' do
      friend_request_from_user.accept
      expect(user.requested_friendships.first.initiator).to eq(user)
    end
  end

  describe '#friendship_accepters' do
    it 'returns the users who approved the friendship of this user' do
      friend_request_from_user.accept
      expect(user.friendship_accepters.first).to eq(friend)
    end
  end

  describe '#accepted_friendships' do
    it 'returns the friendships where this user was the approver' do
      friend_request_to_user.accept
      expect(user.accepted_friendships.first.approver).to eq(user)
    end
  end

  describe '#friendship_requesters' do
    it 'returns the users who initiated friendship with this user' do
      friend_request_to_user.accept
      expect(user.friendship_requesters.first).to eq(friend)
    end
  end

  describe '#sent_friend_requests' do
    it 'returns the friend requests that this user initiated' do
      friend_request_from_user
      expect(user.sent_friend_requests.first.initiator).to eq(user)
    end
  end

  describe '#friend_request_receivers' do
    it 'returns the users that are the approvers of the initiated friend requests of this user' do
      friend_request_from_user
      expect(user.friend_request_receivers.first).to eq(friend)
    end
  end

  describe '#received_friend_requests' do
    it 'returns the friend requests where this user is the approver' do
      friend_request_to_user
      expect(user.received_friend_requests.first.approver).to eq(user)
    end
  end

  describe '#friend_request_senders' do
    it 'returns the users that are the initiators of the friend requests this user has to approve' do
      friend_request_to_user
      expect(user.friend_request_senders.first).to eq(friend)
    end
  end

  # ----------------------------------------
  # Validations
  # ----------------------------------------

  describe 'validates' do
    describe 'email' do
      it 'is present' do
        expect {create(:user, :email => '')}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'is unique' do
        create(:user, :email => 'foo@bar.com')
        expect {create(:user, :email => 'foo@bar.com')}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'fits correct format' do
        expect {create(:user, :email => 'asdf')}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe 'password' do
      it 'cannot have a length less than 8' do
        expect {create(:user, :password => 'a' * 7)}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'cannot have a length more than 32' do
        expect {create(:user, :password => 'a' * 33)}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'cannot have any whitespace' do
        expect {create(:user, :password => 'a b c d e f g h i j k')}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe 'first_name' do
      it 'is present' do
        expect {create(:user, :first_name => '')}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'only contains letters' do
        expect {create(:user, :first_name => 'Freddy 1234 @')}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe 'last_name' do
      it 'is present' do
        expect {create(:user, :last_name => '')}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'only contains letters' do
        expect {create(:user, :last_name => 'Freddy 1234 @')}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe 'birthday' do
      it 'is present' do
        expect {create(:user, :birthday => '')}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe 'gender' do
      it 'is present' do
        expect {create(:user, :gender => nil)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe 'cover_photo' do
      it 'belongs to this user' do
        friend_photo = create(:profile_photo, :user => friend)
        expect {user.update!(:profile_photo => friend_photo)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe 'profile_photo' do
      it 'belongs to this user' do
        friend_photo = create(:cover_photo, :user => friend)
        expect {user.update!(:cover_photo => friend_photo)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  # ----------------------------------------
  # Methods
  # ----------------------------------------

  describe '#create' do
    it 'queues a welcome email to be sent' do
      expect {friend}.to change(Delayed::Job, :count).by(1)
    end
  end

  describe '#profile_photo_url' do
    it 'has a default value when the user has no profile photo' do
      expect(user.profile_photo_url).to_not be_nil
    end

    it 'returns the url of the photo when a profile photo is set' do
      user.update!(:profile_photo => profile_photo)
      expect(user.profile_photo_url).to eq(profile_photo.file.url)
    end

    it 'allows a style to be passed as a parameter' do
      user.update!(:profile_photo => profile_photo)
      expect {user.profile_photo_url(:thumb)}.to_not raise_error
    end
  end

  describe '#cover_photo_url' do
    it 'has a default value when the user has no cover photo' do
      expect(user.cover_photo_url).to_not be_nil
    end

    it 'returns the url of the photo when a cover photo is set' do
      user.update!(:cover_photo => cover_photo)
      expect(user.cover_photo_url).to eq(cover_photo.file.url)
    end

    it 'allows a style to be passed as a parameter' do
      user.update!(:cover_photo => cover_photo)
      expect {user.cover_photo_url(:thumb)}.to_not raise_error
    end
  end

  describe '#name' do
    it 'returns the full name of the user' do
      expect(user.name).to eq("#{user.first_name} #{user.last_name}")
    end
  end

  describe '#create_auth_token' do
    it 'updates the user with a new auth token' do
      auth_token = user.create_auth_token
      user.create_auth_token
      expect(user.auth_token).to_not eq(auth_token)
    end
  end

  describe '#friends' do
    it 'returns all of the users with whom this user is friends' do
      friend_request_to_user.accept
      expect(user.friends.length).to eq(1)
    end
  end

  describe '#friendships' do
    it 'returns all of the friendships associated with this user' do
      friend_request_to_user.accept
      expect(user.friendships.length).to eq(1)
    end
  end

  describe '#friend_requests' do
    it 'returns all of the friend requests associated with this user' do
      friend_request_to_user
      expect(user.friend_requests.length).to eq(1)
    end
  end

  describe '#friendship_with' do
    it 'returns the friendship between the user and the given user' do
      friend_request_to_user.accept
      friendship = user.friendship_with(friend)
      expect([friendship.initiator, friendship.approver]).to eq([friend, user])
    end

    it 'returns a friend request if one exists' do
      friend_request_to_user
      friendship = user.friendship_with(friend)
      expect(friendship).to be_an_instance_of(FriendRequest)
    end

    it 'returns a new friend request if no friend request nor friendship exists' do
      friendship = user.friendship_with(friend)
      expect(friendship).to be_an_instance_of(FriendRequest)
    end
  end

  describe '#friend?' do
    it 'returns true if the user is friends with the given user' do
      friend_request_from_user.accept
      expect(user.friend?(friend)).to eq(true)
    end

    it 'returns false if the user is not friends with the given user' do
      expect(user.friend?(friend)).to eq(false)
    end
  end

  # ----------------------------------------
  # Hooks
  # ----------------------------------------

  describe '#destroy' do
    context 'the user has no friendships or friend requests' do
      before do
        user.destroy!
      end

      it 'destroys all the posts that belong to this user' do
        expect(Post.where(:user_id => user.id)).to be_empty
      end

      it 'destroys all the comments that belong to this user' do
        expect(Comment.where(:user_id => user.id)).to be_empty
      end

      it 'destroys all the likes that belong to this user' do
        expect(Like.where(:user_id => user.id)).to be_empty
      end

      it 'destroys the profile that belongs to this user' do
        expect(Profile.where(:user_id => user.id)).to be_empty
      end
    end

    context 'the user has friendships or friend requests' do
      it 'destroys all associated friendships' do
        friend_request_to_user.accept
        expect {user.destroy!}.to change(Friendship, :count).by(-1)
      end

      it 'destroys all associated friend requests' do
        friend_request_from_user
        expect {user.destroy!}.to change(FriendRequest, :count).by(-1)
      end
    end
  end
end






