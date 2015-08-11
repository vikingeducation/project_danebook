require 'rails_helper'

RSpec.describe Photo, type: :model do

  let(:photo) { build(:photo) }

  it "is valid with default attributes" do
    expect(photo).to be_valid
  end


end
