require "rails_helper"

describe User do
  let(:user){ create(:user) }

  context "associations" do
    it "has one profile" do
      expect{user.profile}.not_to raise_error
    end

    it "has many posts" do
      expect{user.posts}.not_to raise_error
    end

    it "has many likes" do
      expect{user.likes}.not_to raise_error
    end

    it "has many initiated friend requests" do
      expect{user.initiated_friend_requests}.not_to raise_error
    end

    it "has many received friend requests" do
      expect{user.received_friend_requests}.not_to raise_error
    end

    it "has many photos" do
      expect{user.photos}.not_to raise_error
    end

  end

  context "validations" do
    let(:good_password){ make_string("x", 8) }
    let(:bad_password){ make_string("x", 7) }

    it "requires an email" do
      expect{User.create(attributes_for(:user))}.not_to raise_error
      expect{
        User.create(attributes_for(:user, email: nil))
      }.to raise_error(ActiveRecord::StatementInvalid)
    end

    it "fails if the email is not unique" do
      email = "foo@bar.com"
      create(:user, email: email)
      expect{create(:user, email: email)}.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it "password must have at least 8 chars" do
      expect{
        create(:user, password: good_password, password_confirmation: good_password)
      }.not_to raise_error
      expect{
        create(:user, password: bad_password, password_confirmation: bad_password)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "custom methods" do
    context "#generate_token" do
      it "generates a token for an existing user" do
        expect{user.generate_token}.not_to raise_error
      end

      it "generates a unique token" do
        expect(user.generate_token).not_to be eq(user.generate_token)
      end
    end

    context "#regenerate_auth_token" do
      it "generates a new token" do
        expect{user.regenerate_auth_token}.not_to raise_error
      end
    end

    context "#full_name" do
      it "returns the concatenation of the user's first and last names" do
        p = create(:profile, user: user)
        expect(user.full_name).to be == p.first_name + " " + p.last_name
      end
    end

    context "#relationship_with" do
      let(:other_user){ create(:user) }
      let(:friend_request) do
        create(:friend_request,
        user_one_id: user.id,
        user_two_id: other_user.id,
        status_id: create(:status, :accepted).id)
      end
      ## persist
      before { friend_request }

      it "returns the FriendRequest instance between the users" do
        result = user.relationship_with(other_user.id)
        expect(result).to be == friend_request
      end

      it "returns nil if there is no relationship between them" do
        result = create(:user).relationship_with(user.id)
        expect(result).to be nil
      end
    end

    context ".search" do
      let(:profile){ create(:profile, user: user)}
      before{ profile }

      it "returns the user with first_name containing the string" do
        # full match
        search1 = User.search(user.profile.first_name)
        expect(search1).to be == [user]
        # partial match
        half = user.profile.first_name.length / 2
        search2 = User.search(user.profile.first_name[0..half])
        expect(search2).to be == [user]
      end

      it "returns the user with last_name containing the string" do
        # full match
        search1 = User.search(user.profile.last_name)
        expect(search1).to be == [user]
        # partial match
        half = user.profile.last_name.length / 2
        search2 = User.search(user.profile.last_name[0..half])
        expect(search2).to be == [user]
      end

      it "returns an empty array if first_name and last_name does not contain the string" do
        # first name
        search1 = User.search(user.profile.first_name + "won't find me")
        expect(search1).to be == []
        # last name
        search2 = User.search(user.profile.last_name + "won't find me")
        expect(search2).to be == []
      end
    end

    context "#friends_with?" do
      it "returns whether a boolean whether two users are friends" do
        expect(user.friends_with?(create(:user).id)).to be nil
      end
    end
  end

end
