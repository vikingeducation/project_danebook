require 'rails_helper'

include ActionDispatch::TestProcess

RSpec.describe Photo, type: :model do

  let(:photo) { build(:photo) }

  # it "is valid with default attributes" do
  #   expect(photo).to be_valid
  # end

  it "is associated with a user" do
    expect(photo).to respond_to(:user)
  end


end
