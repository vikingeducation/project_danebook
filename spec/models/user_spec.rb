require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){ build(:user) }
  let(:password_min){ 8 }
  let(:password_max){ 24 }

  describe "attributes & validations" do
    it "is valid with default attributes" do
      expect(user).to be_valid
    end

    it "saves with default attributes" do
      expect{ user.save! }.not_to raise_error
    end

    context "when saving multiple users" do
      before do
        user.save!
      end
      it "doesn't allow identical email addresses" do
        new_user = build(:user, :email => user.email)
        expect(new_user).not_to be_valid
      end
    end

    it "with a name and email is valid" do
      expect(user).to be_valid
    end

    it "without a name is invalid" do
      user = build(:user, :name => nil)
      expect(user).not_to be_valid
    end

    it "without an email address is invalid" do
      user = build(:user, :email => nil)
      expect(user).not_to be_valid
    end

    it "returns a user's name as a string" do
      expect(user.name.is_a?(String)).to be == true
    end

    it "with a password that's in the length range is valid" do
      user_1 = build(:user, password: generate_string(password_min))
      user_2 = build(:user, password: generate_string(password_max))
      expect([user_1, user_2]).to all(be_valid)
    end

    it "with a password that's too short is invalid" do
      user = build(:user, password: generate_string(password_min - 1))
      expect(user).not_to be_valid
    end

    it "with a password that's too long is invalid" do
      user = build(:user, password: generate_string(password_max + 1))
      expect(user).not_to be_valid
    end
  end #attributes

  describe "Authorship associations" do
    let( :post ) { create( :post ) }

    specify "linking a valid Author succeeds" do
      user = create( :user )
      post.user = user
      expect( post ).to be_valid
    end

    specify "linking nonexistent author fails" do
      post.user_id = 1234
      expect( post ).not_to be_valid
    end

    it "responds to the posts association" do
      expect(user).to respond_to(:posts)
      expect(user).to respond_to(:authored_posts)
    end

    it "responds to the comments association" do
      expect(user).to respond_to(:comments)
      expect(user).to respond_to(:authored_comments)
    end

    it "responds to the likes association" do
      expect(user).to respond_to(:likes)
      expect(user).to respond_to(:posts_they_like)
      expect(user).to respond_to(:comments_they_like)
    end
  end

  describe "Initiated Friendship Associations" do
    it "responds to the initiated_friendings association" do
      expect(user).to respond_to(:initiated_friendings)
    end

    it "responds to the friended_users association" do
      expect(user).to respond_to(:friended_users)
    end
  end

  describe "Recieved Friendship Associations" do
    it "responds to the received_friendings association" do
      expect(user).to respond_to(:received_friendings)
    end

    it "responds to the users_friended_by association" do
      expect(user).to respond_to(:users_friended_by)
    end
  end

  describe "polymorphic commenting associations" do
    let( :post_comment ) { create( :comment_on_post ) }
    let( :comment_comment ) { create( :comment_on_comment ) }

    specify "comments respond to their parent post association" do
      expect( post_comment ).to respond_to( :commentable )
    end

    specify "comments respond to their parent comment association" do
      expect( comment_comment ).to respond_to( :commentable )
    end

  end

  describe "instance methods" do

    describe "#display_name" do
      it "displays the user's name if a name is present" do
        expect(user.display_name).to eq(user.name)
      end

      it "displays the user's email if there is no name" do
        user.name = nil
        expect(user.display_name).to eq(user.email)
      end
    end

    describe "#friends" do
      let(:user_1){ build(:user) }
      let(:user_2){ build(:user) }

      it 'lists all friends' do
        user.friended_users = [user_1]
        user.users_friended_by = [user_1, user_2]
        expect(user.friends.count).to eq(2)
      end
    end

    describe "#has_friends?" do
      let(:user_1){ build(:user) }

      it 'returns false if a user does not have friends' do
        expect(user.has_friends?).to eq(false)
      end

      it 'returns true if a user has friends' do
        user.friended_users = [user_1]
        expect(user.has_friends?).to eq(true)
      end
    end

    describe "#post_count" do
      let(:num_posts){ 3 }

      before do
        user.posts = create_list(:post, num_posts)
        user.save!
      end

      it "returns the count of a User's posts" do
        expect(user.post_count).to eq(num_posts)
      end
    end # post_count
  end #instance methods

end
