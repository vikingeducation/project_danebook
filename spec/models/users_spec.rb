require 'rails_helper'

describe User do

  let(:user){build(:user)}

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


  # ========== ASSOCIATION TESTS =======================

  it "is responds to assocation with posts" do
    expect(user).to respond_to(:comments)
  end

  it "is responds to assocation with posts" do
    expect(user).to respond_to(:likes)
  end

  it "is responds to assocation with posts" do
    expect(user).to respond_to(:profile)
  end
  # User
  # -associations with comments, like, profile, posts ---happy/sad x 2

  # ========== METHODS TESTS =======================

  # helpers
  # -first_few_likes(post)---happy/sad
  # -current_user_liked?(post)---happy/sad
end
