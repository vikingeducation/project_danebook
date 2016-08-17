require 'rails_helper'

describe User do

  let(:user){ build(:user) }
  let(:another_user){ buil(:user) }
  let(:no_email){ build(:user, :email => "") }
  let(:no_password){ build(:user, :password => "") }
  let(:no_first_name){ build(:user, :first_name => "") }
  let(:no_gender){ build(:user, :gender => "") }

  let(:post){ build(:post)}


  describe "validations" do 

    it "is valid with default attributes" do
      expect(user).to be_valid
    end

    it "is invalid with no email" do
      expect(no_email).not_to be_valid
    end

    it "is invalid with a non-unique email" do 
      create(:user)
      create(:user, :email => user.email)
      expect(user).not_to be_valid
    end

    it "is invalid with no password" do 
      expect(no_password).not_to be_valid
    end

    it "is invalid with no gender" do 
      expect(no_gender).not_to be_valid
    end

    it { is_expected.to validate_length_of(:password).is_at_most(24) }
    it { is_expected.to validate_length_of(:password).is_at_least(8) }

    it { is_expected.to have_secure_password }
  end


  describe "instance methods" do 

    describe "#generate_token" do 
      it "generates an auth token" do 
        user.generate_token

        expect(user.auth_token).not_to be_empty
      end
    end

    describe "#regenerate_auth_token" do 
      it "generates a new auth token" do 
        user.generate_token
        tokenA = user.auth_token
        user.regenerate_auth_token

        expect(user.auth_token).not_to eq(tokenA)
      end
    end

    describe "#name" do 
      it "returns a string of the first and last name separated by a space" do 
        expect(user.name).to eq("#{user.first_name} #{user.last_name}")
      end
    end 
  end
  
  describe "association methods" do 
    describe "#posts" do 

      it "returns all a users posts" do 
        user_post = create(:post, :author => user)
        expect(user.posts).to include(user_post)
      end

    end

    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_one(:profile) }

  end

end