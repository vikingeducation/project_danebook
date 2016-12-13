require 'rails_helper'  
describe User do 

  let ( :user ) { build(:user) }

  describe "validations" do 
    it 'Can create friends' do
      friendship = build(:friend)
      expect(friendship).to be_valid  
    end

    it 'Only Unique friends' do
      f1 = create(:user)
      f2 = create(:user)
      create(:friend, friender: f1, friendee: f2 )
      friendship = build(:friend, friender: f1, friendee: f2 )
      expect(friendship).to_not be_valid  
    end


  end
end