
require 'rails_helper'

describe User do

  let(:default_user){ build(:user) }

  describe 'default_user' do 

    it "is valid with default attributes" do
      expect(default_user).to be_valid
    end

    it "is an User instance" do
      expect(default_user).to be_a User
    end

  end

  describe 'default user saved values' do   

    it "has auth token populated" do
      default_user.save!
      expect(default_user.auth_token).to be_truthy
    end

    it "has username attribute set" do
      default_user.save!
      expect(default_user.username).to be_truthy
    end

    it "has email attribute set" do
      default_user.save!
      expect(default_user.email).to be_truthy
    end

    it "has password attribute set" do
      default_user.save!
      expect(default_user.password).to be_truthy
    end

  end

  describe 'checks user name' do   
    #let(:user_x){ create(:user) }

    it "to not be nil" do
      new_user = build(:user, username: nil)
      expect(new_user).to_not be_valid
    end

    it "to not contain only spaces" do
      new_user = build(:user, username: "    ")
      expect(new_user).to_not be_valid
    end

    it "to not be duplicate" do
      default_user.save!
      new_user = build(:user, username: default_user.username)
      expect(new_user).not_to be_valid
    end

  end

  describe 'checks email' do   

    it "to not be nil" do
      new_user = build(:user, email: nil)
      expect(new_user).to_not be_valid
    end

    it "to not contain spaces" do
      new_user = build(:user, email: "    ")
      expect(new_user).to_not be_valid
    end

    it "to not be duplicate" do
      default_user.save!
      new_user = build(:user, email: default_user.email)
      expect(new_user).to_not be_valid
    end

  end

  describe 'checks password' do   

    it "to not be nil" do
      new_user = build(:user, password: nil)
      expect(new_user).to_not be_valid
    end

    it "to not contain only spaces" do  
      new_user = build(:user, password: "   " * 10)
      expect(new_user).to_not be_valid
    end

    it "to not be less that 8 characters" do  
      new_user = build(:user, password: "f" * 7)
      expect(new_user).to_not be_valid
    end

    it "to not be more that 20 characters" do  
      new_user = build(:user, password: "f" * 21)
      expect(new_user).to_not be_valid
    end

    it "can be a duplicate" do  
      default_user.save!(password: "12345689")
      expect(default_user).to be_valid

      new_user = build(:user, password: "12345678")
      expect(new_user).to be_valid
    end

  end

  describe 'responds to association' do
    
    it "posts association" do
      expect(default_user).to respond_to(:posts)
    end
    
    it "profile association" do
      expect(default_user).to respond_to(:profile)
    end

    it "comments association" do
      expect(default_user).to respond_to(:comments)
    end

    it "likes association" do
      expect(default_user).to respond_to(:likes)
    end

    it "commented_posts association" do
      expect(default_user).to respond_to(:commented_posts)
    end

    it "liked_posts association" do
      expect(default_user).to respond_to(:liked_posts)
    end

    it "initiated friend_requests association" do
      expect(default_user).to respond_to(:initiated_friend_requests)
    end

    it "users_friended_by association" do
      expect(default_user).to respond_to(:users_friended_by)
    end

  end

  # describe 'validates_email' do

  #    it "does not allow duplicate emails" do
  #       new_user = build(:user, :email => user.email)
  #       expect(new_user).not_to be_valid
  #     end

  #     it "does not allow blank email" do
  #       new_user = build(:user, :email => "")
  #       expect(new_user).not_to be_valid
  #     end
  # end

  # describe 'validates_name' do

  #  it "does not allow a name length of less than 3" do
  #       new_user = build(:user, :name => 'fo')
  #       expect(new_user).not_to be_valid
  #     end

  #   it "does not allow a name length of more than 20" do
  #       new_user = build(:user, :name => 'foooooooooooooooooooo')
  #       expect(new_user).not_to be_valid
  #   end  

  # end

  # describe 'validates_password' do

  #   it "does not allow a password length of less than 6" do
  #       new_user = build(:user, :password => '12345')
  #       expect(new_user).not_to be_valid
  #   end

  #   it "does not allow a password length of more than 16" do
  #       new_user = build(:user, :password => '12345678901234567')
  #       expect(new_user).not_to be_valid
  #   end  

  #   it "does allow to update user without password" do
  #       new_user = create(:user)
  #       expect {
  #         new_user.update!(name: "xyzabc", email: "thisuser@aol.com")
  #       }.to_not raise_error
  #   end  
  
  # end

  # describe 'checks secrets association' do
  #   it "responds to the secrets association" do
  #     new_user = build(:user)
  #     expect(new_user).to respond_to(:secrets)
  #   end
  # end

  # describe 'checks that multiple secrets can be created for user' do
  #   let(:user){ build(:user) }
  #   it "gives 5 secrets when 5 are assigned to author" do
  #     secrets = create_list(:secret, 5, author: user)
  #     expect(user.secrets.count).to eq(5)
  #   end
  # end  

  # describe 'checks that multiple users can be created' do
  #   it "gives 10 users" do
  #     users = create_list(:user, 10)
  #     expect(users.count).to eq(10)
  #   end
  # end  

end