require 'rails_helper'

describe Post do
  # let(:user){ create(:user) }
  let(:post){ build(:post) }

  describe 'validations' do

    it 'should save with default attributes' do
      post.save
      expect(post).to be_valid
    end

    it 'should not be valid if user is nil' do
      invalid_post = build(:post, :user_id => nil)
      expect(invalid_post).not_to be_valid
    end

    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:user) }

  end

  describe 'associations' do

    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }   

  end

end