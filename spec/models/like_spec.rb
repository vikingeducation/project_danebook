require 'rails_helper'

describe Like do

  context 'when using polymorphism' do

    let(:test_like) { create(:post_like) }
    let(:comment) { build(:comment) }
    let(:user) { build(:user) }

    it 'accepts a Post as its parent' do
      expect(test_like).to be_valid
    end

    it 'accepts a Comment as its parent' do
      test_like.liked = comment
      expect(test_like).to be_valid
    end

    #it 'does not save a duplicate [liker_id, liked_id, liked_type]'

  end

end