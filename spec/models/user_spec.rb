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

  # Custom Methods
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

end
