require 'rails_helper'

describe User do
  let(:user){ build(:user) }

  describe 'attributes' do
    it 'email should be unique' do
      should validate_uniqueness_of(:email)
    end

    it 'has secure password' do
      should have_secure_password
    end

    it 'name is acceptable length' do
      should validate_length_of(:first_name).is_at_least(1).is_at_most(50)
      should validate_length_of(:last_name).is_at_least(1).is_at_most(50)
    end

    # it 'password is acceptable length' do
    #   should validate_length_of(:password).is_at_least(1).is_at_most(30)
    # end

    it 'birthday values should only accept integer values' do
      should validate_numericality_of(:birth_date).only_integer
      should validate_numericality_of(:birth_month).only_integer
      should validate_numericality_of(:birth_year).only_integer
    end

    it 'user with non-integer birthday values is invalid' do
      non_valid_user = build(:user, :birth_date => 1.2)
      expect(non_valid_user).not_to be_valid
    end
  end

  describe 'associations' do
    it 'responds to posts association' do
      expect(user).to respond_to(:posts)
    end

    it 'responds to profile association' do
      expect(user).to respond_to(:profile)
    end

    it 'responds to comments association' do
      expect(user).to respond_to(:comments)
    end

    it 'responds to likes association' do
      expect(user).to respond_to(:likes)
    end

    it 'accepts nested attributes for profile' do
      should accept_nested_attributes_for(:profile)
    end
  end


end