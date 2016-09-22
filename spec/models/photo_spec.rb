require 'rails_helper'

describe Photo do

  describe "Associations" do 

    let(:photo) { create(:photo) }

    it "validates the presence of content" do 
      is_expected.to respond_to(:profile)
    end

  end
end
