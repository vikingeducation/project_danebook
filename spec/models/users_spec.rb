require 'rails_helper'

describe User do

  let(:user){build(:user)}
  let(:profile){build(:profile)}

# ========== VALIDATIONS TESTS =======================
# ----------USER -------------
  it "without an email is invalid" do
    new_user = build(:user, :email => nil)
    expect(new_user).not_to be_valid
  end

  it "with correct email is valid" do
    new_user = build(:user)
    expect(new_user).to be_valid
  end

  it "with correct password is valid" do
    new_user = build(:user, :password => 'ee')
    expect(new_user).not_to be_valid
  end

  it "with empty password is invalid" do
    new_user = build(:user, :password => '')
    expect(new_user).not_to be_valid
  end

  context "when saving multiple users" do
    before do
      user.save!
    end
    it "with a duplicate email is invalid" do
      new_user = build(:user, :email => user.email)
      expect(new_user).not_to be_valid
    end
  end

# ---------- PROFILE -------------
  it "with missing first name is invalid" do
    test_profile = build(:profile, :first_name => '')
    expect(test_profile).not_to be_valid
  end

  it "with too short last name is invalid" do
    test_profile = build(:profile, :last_name => 'D')
    expect(test_profile).not_to be_valid
  end

  it "with correct all details is valid" do
    expect(profile).to be_valid
  end

  it "with letterized telephone num is invalid" do
    test_profile = build(:profile, :telephone => '+123asd789')
    expect(test_profile).not_to be_valid
  end

  # ========== ASSOCIATION TESTS =======================
  # ----------USER -------------


  # Comment
  # -association with likes, user, posts  ---happy/sad x 2
  # linking a valid Author succeeds



  # Like
  # -associations with user, comments, posts  ---happy/sad x 2




  # Post
  # -associations with comments, user, likes  ---happy/sad x 2


  # Profile
  # -association with user  ---happy/sad


  # User
  # -associations with comments, like, profile, posts ---happy/sad x 2

  # ========== METHODS TESTS =======================
  # ----------USER -------------


  # helpers
  # -first_few_likes(post)---happy/sad
  # -current_user_liked?(post)---happy/sad
end
