require 'rails_helper'

describe Post do
  let(:post){ build(:post) }

  it "is valid out of the gate" do
    expect(post).to be_valid
  end

  describe "associations" do
    context "associating with other objects" do
      it "responds to user" do 

      end
      
      it "responds to comments" do

      end

      it "responds to likes" do

      end
    end
  end
end