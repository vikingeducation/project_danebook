require 'rails_helper'

describe User do
  it_behaves_like 'Dateable'
  it_behaves_like 'Searchable'

  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:profile){user.profile}
  let(:posts){create_list(:post, 2, :user => user)}
  let(:post_comments){create_list(:post_comment, 2, :user => user, :commentable => posts.first)}
  let(:post_like){create(:post_like, :user => user, :likeable => posts.first)}
  let(:comment_like){create(:comment_like, :user => user, :likeable => post_comments.first)}

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
    it 'returns the profile photo for this user'
  end

  describe '#cover_photo' do
    it 'returns the cover photo for this user'
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
    it 'returns all photos for this user'
  end

  describe '#requested_friendships' do
    it 'returns the friendships where this user was the initiator'
  end

  describe '#friendship_accepters' do
    it 'returns the users who approved the friendship of this user'
  end

  describe '#accepted_friendships' do
    it 'returns the friendships where this user was the approver'
  end

  describe '#friendship_requesters' do
    it 'returns the users who initiated friendship with this user'
  end

  describe '#sent_friend_requests' do
    it 'returns the friend requests that this user initiated'
  end

  describe '#friend_request_receivers' do
    it 'returns the users that are the approvers of the initiated friend requests of this user'
  end

  describe '#received_friend_requests' do
    it 'returns the friend requests where this user is the approver'
  end

  describe '#friend_request_senders' do
    it 'returns the users that are the initiators of the friend requests this user has to approve'
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
      it 'belongs to this user'
    end

    describe 'profile_photo' do
      it 'belongs to this user'
    end
  end

  # ----------------------------------------
  # Methods
  # ----------------------------------------

  describe '#create' do
    it 'queues a welcome email to be sent'
  end

  describe '#profile_photo_url' do
    it 'has a default value when the user has no profile photo'
    it 'returns the url of the photo when a profile photo is set'
    it 'allows a style to be passed as a parameter'
  end

  describe '#cover_photo_url' do
    it 'has a default value when the user has no cover photo'
    it 'returns the url of the photo when a cover photo is set'
    it 'allows a style to be passed as a parameter'
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
    it 'returns all of the users with whom this user is friends'
  end

  describe '#friendships' do
    it 'returns all of the friendships associated with this user'
  end

  describe '#friend_requests' do
    it 'returns all of the friend requests associated with this user'
  end

  describe '#friendship_with' do
    it 'returns the friendship between the user and the given user'
    it 'returns a friend request if one exists'
    it 'returns a new friend request if no friend request nor friendship exists'
  end

  describe '#friend?' do
    it 'returns true if the user is friends with the given user'
  end

  # ----------------------------------------
  # Hooks
  # ----------------------------------------

  describe '#destroy' do
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

    it 'destroys all associated friendships'

    it 'destroys all associated friend requests'
  end
end






