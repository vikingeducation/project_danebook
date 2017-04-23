require 'rails_helper'

describe User do
  let(:user){ build(:user)}
  let(:full_user){ build(:profile)}
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
  describe '#first_name' do
    it 'returns a User\'s first name' do
      user = full_user.user
      expect(user.first_name).to eq(full_user.first_name)
    end
  end
  describe '#is_friends_with?' do
    let(:user){ create(:user)}
    let(:friend){ create(:user)}
    it 'returns true if user is friends with another user' do
      user.friendees << friend
      expect(user.is_friends_with?(friend)).to eq(true)
    end
    it 'returns false if user is not friends with another user' do
      user.friendees << friend
      friend2 = create(:user)
      expect(user.is_friends_with?(friend2)).to eq(false)
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





end
