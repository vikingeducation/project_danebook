require 'rails_helper'

describe User do

  let(:user){build(:user)}
  let(:full_pass){build(:user, password: "#{'a'*10}1A")}
  let(:short_pass){build(:user, password: "#{'a'*9}1A")}
  let(:numberless_pass){build(:user, password: "#{'a'*10}A")}
  let(:no_cap_pass){build(:user, password: "#{'a'*12}1")}
  let(:crazy_pass){build(:user, password: "!@$%^&*()\##{'a'*12}A1")}
  let(:dup_email){build(:user, email: user.email)}
  let(:double_a_email){build(:user, email: "22@@a.com")}
  let(:no_domain_email){build(:user, email: "22@.com")}
  let(:no_u_email){build(:user, email: "@a.com")}
  let(:no_tld_email){build(:user, email: "22@a.")}

  it "requires a strong password" do
    expect(full_pass).to be_valid
    expect(short_pass).to_not be_valid
    expect(numberless_pass).to_not be_valid
    expect(no_cap_pass).to_not be_valid
  end

  it "allows any character in the password" do
    expect(crazy_pass).to be_valid
  end

  it "requires a unique email" do
    user.save
    expect(dup_email).to_not be_valid
  end

  it "skips password validation if nil on update" do
    user.save
    user.update_attributes(email: "asdf@asdf.com")
    expect(user).to be_valid
    user.update_attributes(email: "asdf@asdf.com", password: "f")
    expect(user).to_not be_valid
  end

  it "requires emails to be emails" do
    expect(double_a_email).to_not be_valid
    expect(no_domain_email).to_not be_valid
    expect(no_u_email).to_not be_valid
    expect(no_tld_email).to_not be_valid
  end

  it 'downcases all emails' do
    user.update_attributes(email: "AsDf@ASDF.coM")
    expect(user.email).to eq("asdf@asdf.com")
  end

  it 'creates a profile images gallery for new users' do
    expect(user.galleries.size).to eq(0)
    user.save
    expect(user.galleries.size).to eq(1)
    user.update_attributes(email: "AsDf@ASDF.coM")
    expect(user.galleries.size).to eq(1)
  end

  describe "#regenerate_auth_token" do
    it "destroys the old token and generates a new one" do
      user.save
      user.regenerate_auth_token
      old_token = user.token
      user.regenerate_auth_token
      expect(user.token).to_not eq(old_token)
    end
  end

  describe "#destroy_token" do
    it "destroys the old token" do
      user.save
      user.regenerate_auth_token
      user.destroy_token
      expect(user.token).to be_nil
    end
  end
  
  it { is_expected.to have_secure_password }
  it { is_expected.to have_one(:profile) }
  it { is_expected.to have_many(:f_requests) }
  it { is_expected.to have_many(:friend_requests) }
  it { is_expected.to have_many(:r_friends) }
  it { is_expected.to have_many(:requested_friends) }
  it { is_expected.to have_many(:friend_requests) }
  it { is_expected.to have_many(:friends) }
  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:likes) }
  it { is_expected.to have_many(:liked_posts) }
  it { is_expected.to have_many(:galleries) }
end
