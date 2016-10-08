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

      it do
      should validate_presence_of(:first_name)
    end

    it do
      should validate_presence_of(:last_name)
    end

    it do
      should validate_presence_of(:email)
    end

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

    it 'validates and rejects email without @' do
      new_user = build(:user, email: "foobarr.com")
      expect(new_user).not_to be_valid
    end

    it 'validates email with @' do
      new_user = build(:user, email: "foo@barr.com")
      expect(new_user).to be_valid
    end

    it 'validates email length of between 4 & 50' do
      should validate_length_of(:email).
        is_at_least(4).is_at_most(50)
    end

    it 'validates birth_date over 125 years ago is not valid' do
      new_user = build(:user, birth_date: 126.years.ago)
      expect(new_user).not_to be_valid
    end

    it 'validates birth_date 125 years ago is valid' do
      new_user = build(:user, birth_date: 125.years.ago)
      expect(new_user).to be_valid
    end

    it 'validates birth_date in future is not valid' do
      new_user = build(:user, birth_date: 126.years.from_now)
      expect(new_user).not_to be_valid
    end

    it 'validates birth_date of current day is valid' do
      new_user = build(:user, birth_date: Date.today)
      expect(new_user).to be_valid
    end
  end

  context "should have_secure_password" do
      subject{user}
      it { is_expected.to have_secure_password }
  end

  # ----------------------------------------
  # Associations
  # ----------------------------------------
  context "associations with children and parents are valid" do
    subject{user}

    it { is_expected.to belong_to(:profile_pic) }
    it { is_expected.to belong_to(:cover_pic) }

    it { should have_one(:profile).dependent(:destroy) }

    it { should have_many(:comments).dependent(:destroy) }

    it { is_expected.to have_many(:postings).dependent(:destroy) }
    it { is_expected.to have_many(:text_posts).dependent(:destroy) }
    it { is_expected.to have_many(:photo_posts).dependent(:destroy) }


    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:liked_posts).through(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:liked_photos).through(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:liked_comments).through(:likes).dependent(:destroy) }

    it { is_expected.to have_many(:initiated_friendings).dependent(:nullify) }
    it { is_expected.to have_many(:friended_users) }

    it { is_expected.to have_many(:received_friendings).dependent(:nullify) }
    it { is_expected.to have_many(:users_friended_by) }
  end

  context "after create methods" do
    let(:user_one){ create(:user) }

    it { expect(user_one.profile).to_not be_nil }
  end

  context "helper methods" do
    let(:user_one){ create(:user) }
    let(:photo){ user_one.photo_posts.create }

    it 'photo_count returns count of users photo posts' do
      photo
      expect(user_one.photo_count).to eq(1)
    end

    it 'returns full name of user' do
      expect(user_one.full_name).to eq("#{user_one.first_name} #{user_one.last_name}")
    end
  end
end
