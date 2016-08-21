require 'rails_helper'

describe Post, type: :model do
  let(:user) { create(:user) }

  it 'with a valid description is validd' do
    post = user.text_posts.create(description: "blah")
    expect(post).to be_valid
  end

  context "post attribute validations reject unwanted entries" do
    let(:post_two){ user.text_posts.create }
    subject{post_two}

    it 'validates post description is between 1 and 800 characters' do
      should validate_length_of(:description).
        is_at_least(1).is_at_most(800)
    end
  end

  context "test assocations with user" do

    it { is_expected.to have_many(:postings) }
    it { is_expected.to have_many(:authors) }

    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:commenters) }

    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:likers) }
  end

  context "helper methods" do
    it 'returns pluralized name of Post class when to_s called on instance' do
      post = user.text_posts.create(description: "blah")
      expect(post.to_s).to eq("posts")
    end
  end

end
