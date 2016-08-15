require 'rails_helper'
describe User do
  let(:user){ build(:user) }
  let(:friendly_user) { build(:friendly_user) }

  describe 'attributes' do
    it "is valid with default attributes" do
      expect(user).to be_valid
    end
    it "saves with default attributes" do
      expect{ user.save! }.not_to raise_error
    end
    it "generates a token upon creation" do
      user.save!
      expect(user.auth_token).to be_a(String)
    end
    it { should validate_presence_of(:email)}
    it { should validate_uniqueness_of(:email)}
    it { should validate_presence_of(:password)}
    it { should validate_length_of(:password).is_at_least(6)}
    it { should have_secure_password }
  end
  context "when saving multiple users" do
    before { user.save! }
    it "doesn't allow identical emails" do
      new_user = build(:user, email: user.email)
      expect(new_user).not_to be_valid
    end
  end

  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:likes) }
    it { should have_many(:comments) }
    it { should have_one(:profile) }
  end


  context "friends!" do
    let!(:profile) { build(:profile) }
    let!(:friends) { user.friended_users = create_list(:user, 4, profile: profile)}
    let!(:friend) { create(:user, profile: profile) }

    describe '#friends' do
      it "returns an array of all friends" do
        friends.each { |friend| user.users_friended_by << friend }
        user.save!
        expect(user.friends).to match_array(friends)
      end
    end

    describe '#make_friend' do
      it 'should make a friend' do
        user.make_friend(friend)
        user.save!
        expect(user.friends).to contain_exactly(friend)
      end
    end

    describe '#unfriend' do
      it 'should unfriend a friend' do
        user.make_friend(friend)
        user.unfriend(friend)
        user.save!
        expect(user.friends).to be_empty
      end
    end

    describe '#friends?' do
      it 'should check if friends' do
        user.make_friend(friend)
        user.save!
        expect(user.friends?(friend)).to be true
      end
    end
  end
end
