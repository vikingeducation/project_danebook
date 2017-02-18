require 'rails_helper'

describe "posts/index.html.erb" do

  before do
    user = create(:user)
    assign(:user, user)
    post = Post.new
    assign(:post, post)
    def view.current_user
      @user
    end
  end

  context "current user has no friends" do

    before do
      assign(:posts, [])
    end

    it "advises the user to make friends" do
      render
      expect(rendered).to match("NO FRIENDS")
    end

  end

  context "current user has a friend" do

    before do
      diff_user = create(:user, :diff_user)
      post = create(:post, author: diff_user)
      assign(:posts, [post])
    end

    it "displays posts that friend has made" do
      render
      expect(rendered).to match("THIS IS ME POST")
    end

  end

end