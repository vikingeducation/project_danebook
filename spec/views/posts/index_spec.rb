require 'pry'

require 'rails_helper'

describe 'posts/index.html.erb' do

  let(:user){create(:user)}
  let(:profile){create(:profile, :user_id => user.id)}
  let(:post){create(:post, :user_id => user.id)}


  before do
    users = [user, create(:user), create(:user), create(:user)]
    profiles = [profile, create(:profile), create(:profile), create(:profile)]
    users.each do |user|
      assign(:user, user)
    end

    profiles.each do |profile|
      assign(:profile, profile)
    end

    assign(:post, post)
    def view.signed_in_user?
      true
    end

    def view.current_user
      @user
    end
  end

  context "renderes correct likes in timeline" do
    let(:like){post.likes.create(attributes_for(:post_like, :user_id => User.first.id))}
    before do
      assign(:like, like)
      @user = user
    end
    it "with one user who liked " do
      render

      expect(rendered).to have_selector("a.liking[href=\'#{user_path(User.first)}\']", :text => "#{full_name(Like.all.last)}")
    end

    # it "with 2 users who liked " do
    #   render
    #   expect(rendered).to have_selector("a[href=\'#{session_path}\']", :text => "Logout")
    # end
    #
    # it "with 4 users who liked " do
    #   render
    #   expect(rendered).to have_selector("a[href=\'#{session_path}\']", :text => "Logout")
    # end
  end

end
