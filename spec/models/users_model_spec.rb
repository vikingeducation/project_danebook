require 'rails_helper'

describe User do

  let(:user) { build(:user) }

  it 'saves with default attributes' do
    expect { user.save! }.to_not raise_error
  end

  it 'does not allow users to have the same email as another' do
    user.save
    new_user = build(:user)
    new_user.email = user.email
    expect(new_user).to be_invalid
  end

  # it 'does not create a user if password confirmation does not match password' do
  #   should validate_confirmation_of(:password)
  # end

  it 'has a secure password' do
    should { have_secure_password }
  end

  it 'accepts nested attributes for profile' do
    user.save
    should { accepted_nested_attributes_for(:profile) }
  end

  it 'responds to the liked_posts association' do
    expect(user).to respond_to(:liked_posts)
  end

  describe '#regenerate_auth_token' do

    it 'can regenerate a new authorization token' do
      user.regenerate_auth_token
      expect(user.auth_token).to_not be_nil
    end

  end

end