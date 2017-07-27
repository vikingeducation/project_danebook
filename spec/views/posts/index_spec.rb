require 'rails_helper'
require 'pry'

describe 'posts/index.html.erb' do

  let(:user){create(:user)}
  let(:another_user){create(:user)}
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

  context "renderes correct likes in timeline" do
    # let(:like){post.likes.create(attributes_for(:post_like, :user_id => User.first.id))}
    # before do
    #   assign(:like, like)
    #   @user = user
    # end

    it "when noone liked " do
      render
      expect(rendered).to have_content("Like")
    end

    it "with current user who liked a post " do
      assign(:user, another_user)
      post.likes << another_user
      render
      binding.pry
      expect(rendered).to have_content("#{full_name(Like.all.last)} like this")
    end
    #
    # it "with another user who liked a post " do
    #   render
    #   expect(rendered).to have_selector("a[href=\'#{session_path}\']", :text => "Logout")
    # end
    #
    # it "with another 2 users who liked a post " do
    #   render
    #   expect(rendered).to have_selector("a[href=\'#{session_path}\']", :text => "Logout")
    # end
    #
    # it "with more than 2 users who liked a post " do
    #   render
    #   expect(rendered).to have_selector("a[href=\'#{session_path}\']", :text => "Logout")
    # end

  end

end
