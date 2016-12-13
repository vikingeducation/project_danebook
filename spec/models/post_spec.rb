require 'rails_helper'   
describe Post do 

  let ( :post ) { build(:post) }

  describe "validations" do 
    it 'Can be created' do
      expect(post).to be_valid
    end

    it 'Posts must be at least 8 characters' do
      post = build(:post, body: "1")
      expect(post).to_not be_valid
    end
  end
     # associations
    describe "associations" do
      it "expect to have likes" do
        expect(post).to respond_to(:likes)
      end

      it "expect to have an user" do
        expect(post).to respond_to(:user)
      end

       it "expect to have comments" do
        expect(post).to respond_to(:comments)
      end

    end
end