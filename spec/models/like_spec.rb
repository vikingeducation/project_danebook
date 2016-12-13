require 'rails_helper'  
describe Like do 

  let ( :like ) { build(:like) }

  describe "validations" do 
    it 'Can be created' do
      expect(like).to be_valid
    end

    it "Can't be created on the same object twice" do 
      object = create(:post)
      user = create(:user)
      like = create(:like, :user => user, :likeable => object)
      like2 = build(:like, :user => user, :likeable => object)
      expect(like2).to_not be_valid
    end 
  end
     # associations
    describe "associations" do
      it "expect to have an object" do
        expect(like).to respond_to(:likeable)
      end

      it "expect to have an user" do
        expect(like).to respond_to(:user)
      end
    end
end