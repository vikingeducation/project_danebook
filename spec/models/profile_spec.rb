require 'rails_helper'

describe Profile do

  let(:profile){build(:profile)}

  it "should be valid with valid parameters" do
    expect(profile).to be_valid
  end

  it { should validate_length_of(:first_name).is_at_most(40).on(:update)}

  it { should validate_length_of(:last_name).is_at_most(40).on(:update)}

  it { should validate_length_of(:college).is_at_most(40).on(:update)}

  it { should validate_length_of(:hometown).is_at_most(40).on(:update)}

  it { should validate_length_of(:currently_lives).is_at_most(40).on(:update)}

  it { should validate_length_of(:words_to_live_by).is_at_most(300).on(:update)}

  it { should validate_length_of(:about_me).is_at_most(300).on(:update)}


  it { should validate_length_of(:telephone).is_at_most(15).on(:update)}

  it { should validate_length_of(:telephone).is_at_least(10).on(:update)}

  it {should belong_to(:user)}




end