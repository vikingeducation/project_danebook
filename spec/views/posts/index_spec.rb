require 'rails_helper'
require 'pry'

describe 'posts/index.html.erb' do

  let(:another_user){create(:user)}
  let(:another_profile){create(:profile, :user_id => another_user.id)}
  let(:user){create(:user)}
  let(:profile){create(:profile, :user_id => user.id)}
  let(:post){create(:post, :user_id => user.id)}

  before do
    assign(:user, user)
    assign(:post, post)
    assign(:profile, profile)

    posts = [post]
    assign(:posts, posts)

    def view.signed_in_user?
      true
    end

    def view.current_user
      @user
    end


  end

  context "renders correct likes in timeline" do

    it "no like info when noone liked " do
      render
      expect(rendered).to have_content("Like")
      expect(rendered).not_to have_content("liked this post")
    end

    it "with current user who liked a post " do
      post.likers << user
      render
      expect(rendered).to have_content("You like this")
    end

    it "with another user who liked a post " do
      assign(:user, another_user)
      assign(:profile, another_profile) 
      post.likers << user
      render
      expect(rendered).to have_content("#{full_name(Like.last)} like this")
    end

    it "with current and another user who liked a post " do #wrong outcome
      assign(:user, another_user)
      assign(:profile, another_profile)
      post.likers << another_user
      post.likers << user
      render
      expect(rendered).to have_content("You and #{full_name(Like.last)} like this")
    end

    it "with more than 2 users who liked a post " do
      # assign(:user, another_user)
      # assign(:profile, another_profile)
      # post.likers << user
      # post.likers << another_user
      # render
      # expect(rendered).to have_content("You and #{full_name(Like.last)} like this")
    end

  end

end
