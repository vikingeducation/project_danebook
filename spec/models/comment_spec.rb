require 'rails_helper'         
describe Comment do  
 
  let ( :comment ) { build(:comment) }

  describe "validations" do 
    it 'Can be created' do
      expect(comment).to be_valid
    end

    it 'Comments must be at least 8 characters' do
      comment = build(:comment, body: "1")
      expect(comment).to_not be_valid
    end
  end
     # associations
    describe "associations" do
      it "expect to have likes" do
        expect(comment).to respond_to(:likes)
      end

      it "expect to have an user" do
        expect(comment).to respond_to(:user)
      end
    end
end