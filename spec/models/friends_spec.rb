require 'rails_helper'  
describe User do 

  let ( :user ) { build(:user) }

  describe "validations" do 
    it 'Only Unique friends' do
      f = Friend.new << user
      f2 = Friend.new << user
      expect(f2).to be_valid
    end
  end
end