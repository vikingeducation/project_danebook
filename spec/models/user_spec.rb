require 'rails_helper'

describe User, type: :model do

  let(:user) { build(:user) }

  it 'with a valid with first name, last name, email, birthdate, and password is valid' do
        expect(user).to be_valid
  end

  it 'without a first name is invalid' do
      new_user = build(:user, first_name: nil)
      expect(new_user).not_to be_valid
  end

  it 'without a first name is invalid' do
      new_user = build(:user, last_name: nil)
      expect(new_user).not_to be_valid
  end

  it 'without a email is invalid' do
      new_user = build(:user, email: nil)
      expect(new_user).not_to be_valid
  end

  it 'without a password is invalid' do
      new_user = build(:user, password: nil, password_confirmation: nil)
      expect(new_user).not_to be_valid
  end

  context "user attribute validations reject unwanted entries" do
    subject{user}

    it 'validates first_name is greater than 1' do
      should validate_length_of(:first_name).
        is_at_least(1).
        on(:create)
    end

    it 'validates last_name is greater than 1' do
      should validate_length_of(:last_name).
        is_at_least(1).
        on(:create)
    end

    it 'validates password length is betwen 8 - 24' do
      should validate_length_of(:password).
        is_at_least(8).is_at_most(24)
    end
  end

end
