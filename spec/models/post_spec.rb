require 'rails_helper'

describe Post do
  let(:post) { build(:post) }

  it { should validate_length_of(:body).is_at_least(1)}
  it { should have_many(:likes)}
  it { should have_many(:comments)}
  it { should belong_to(:author)}

  describe '#get_recent_likes' do
    let!(:likes) { post.likes = create_list(:post_like, 5) }
    it 'should list the three most recent likes in decending order' do
      post.save!
      last_3 = Like.order(id: :desc).limit(3)
      expect(post.get_recent_likes).to match_array(last_3)
    end
  end
end
