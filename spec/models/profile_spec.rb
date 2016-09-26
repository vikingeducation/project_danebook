require 'rails_helper'

describe Profile do
  let(:profile){build(:profile)}

  describe 'validations' do

    it "is valid with default attributes" do
      expect(profile).to be_valid
    end

    it "saves with default attributes" do
      expect{ profile.save! }.to_not raise_error
    end

    it "doesn't allow first_name to be nil/empty" do
      new_user = build(:profile, :first_name => nil)
      expect(new_user.valid?).to eq(false)
    end
 
    it "doesn't allow last_name to be nil/empty" do
      new_user = build(:profile, :last_name => nil)
      expect(new_user.valid?).to eq(false)
    end

    context "month" do

      it "doesn't allow month to be a non-string" do
        new_user = build(:profile, :month => 123)
        expect(new_user.valid?).to eq(false)
      end
    end

    context "day" do

      it "doesn't allow day to be a non-integer" do
        new_user = build(:profile, :day => "hehe")
        expect(new_user.valid?).to eq(false)
      end

      it "doesn't allow day to be a below 1" do
        new_user = build(:profile, :day => 0)
        expect(new_user.valid?).to eq(false)
      end

      it "allow day to be a 1" do
        new_user = build(:profile, :day => 1)
        expect(new_user.valid?).to eq(true)
      end

      it "doesn't allow day to be a above 30" do
        new_user = build(:profile, :day => 31)
        expect(new_user.valid?).to eq(false)
      end

      it "allow day to be a 30" do
        new_user = build(:profile, :day => 30)
        expect(new_user.valid?).to eq(true)
      end
    end

    context "year" do

      it "doesn't allow year to be a non-integer" do
        new_user = build(:profile, :year => "hehe")
        expect(new_user.valid?).to eq(false)
      end

      it "doesn't allow year to be a below 1900" do
        new_user = build(:profile, :year => 1899)
        expect(new_user.valid?).to eq(false)
      end

      it "allow year to be a 1900" do
        new_user = build(:profile, :year => 1900)
        expect(new_user.valid?).to eq(true)
      end

      it "doesn't allow year to be a above 2016" do
        new_user = build(:profile, :year => 2017)
        expect(new_user.valid?).to eq(false)
      end

      it "allow year to be a 2016" do
        new_user = build(:profile, :year => 2016)
        expect(new_user.valid?).to eq(true)
      end
    end

    describe 'gender' do
      it "valid when gender to be male" do
        new_user = build(:profile, :gender => "male")
        expect(new_user.valid?).to eq(true)
      end

      it "valid when gender to be female" do
        new_user = build(:profile, :gender => "female")
        expect(new_user.valid?).to eq(true)
      end

      it "invalid when gender is not male/female" do
        new_user = build(:profile, :gender => 123123)
        expect(new_user.valid?).to eq(false)
      end
    end
  end
  describe 'associations' do
    it "responds to user association" do
      expect(profile).to respond_to(:user)
    end
  end
end