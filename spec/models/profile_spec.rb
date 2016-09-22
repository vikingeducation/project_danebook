require 'rails_helper'

describe Profile do

  describe "associations" do 
    it "has one user" do 
      is_expected.to belong_to(:user)
    end
  end

end