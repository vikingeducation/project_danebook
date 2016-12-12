require 'rails_helper'
describe User do

  let ( :user ) { build(:user) }

  describe "validations" do 
    it 'with name and email is valid' do
      expect(user).to be_valid
    end
  end

  # associations
  describe "associations" do
    
  end

  # methods
  describe "methods" do 
    
  end
end