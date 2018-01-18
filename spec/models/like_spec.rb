require 'rails_helper'

describe Like, type: :model do

  describe "Likes on Posts" do
    let(:post_like){ build(:like_on_post) }

    describe "Associations" do
      it 'responds to author associations' do
        expect(post_like).to respond_to(:user)
      end

      it 'responds to parent associations' do
        expect(post_like).to respond_to(:likeable)
      end
    end #associations


    describe "Validations" do
      let(:post){ create(:post) }
      let(:current_user){ create(:user) }
      let(:user_2){ create(:user) }

      it "is valid with default attributes" do
        expect(post_like).to be_valid
      end

      it "saves with default attributes" do
        expect{ post_like.save! }.not_to raise_error
      end

      it "is invalid without an author" do
        like = build(:like_on_post, user_id: nil)
        expect(like).to_not be_valid
      end

      it "is invalid without a likeable parent type" do
        like = build(:like_on_post, likeable_type: nil)
        expect(like).to_not be_valid
      end

      it "is invalid without a likeable parent id" do
        like = build(:like_on_post, likeable_id: nil)
        expect(like).to_not be_valid
      end

      it "only allows 1 like per user" do
        post.likes.destroy_all
        post.likes.create(user_id: current_user.id)
        expect(post.likes.last.user_id).to eq(current_user.id)
        expect(post.likes.build(user_id: current_user.id)).to_not be_valid
      end
    end #validations
  end #likes on posts

  describe "Likes on Comments" do
    let(:comment_like){ build(:like_on_post_comment) }

    describe "Associations" do
      it 'responds to author associations' do
        expect(comment_like).to respond_to(:user)
      end

      it 'responds to parent associations' do
        expect(comment_like).to respond_to(:likeable)
      end
    end #associations
  end #likes on comments

  describe "Class level methods" do
      describe '.current_user_like' do
        let(:post){ create(:post) }
        let(:current_user){ create(:user) }
        let(:user_2){ create(:user) }

        it 'retrieves the like made by the current user' do
          post.likes.create([{user_id: current_user.id},{user_id: user_2.id}])
          # binding.pry
          expect(Like.current_user_like(post, current_user)).to eq(current_user.likes.last)
        end
      end
    end #class methods


end #Friending
