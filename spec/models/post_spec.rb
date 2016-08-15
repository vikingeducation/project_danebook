require 'rails_helper'

describe Post do

  describe "Validations" do 

    let(:post) { build(:post) }

    it "validates the presence of content" do 
      is_expected.to validate_presence_of(:content)
    end

    it "validates the length of the post" do 
      is_expected.to validate_length_of(:content).is_at_least(1)
    end

  end

  describe "Associations" do 
    it "accepts nested attributes for a comment" do 
      is_expected.to accept_nested_attributes_for(:comments)
    end

    it "only has one user" do 
      is_expected.to belong_to(:user)
    end

    it "has many comments" do 
      is_expected.to have_many(:comments)
    end

    it "has many likes" do 
      is_expected.to have_many(:likes)
    end

  end

end