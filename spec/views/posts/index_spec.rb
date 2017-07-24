require 'pry'

require 'rails_helper'

describe 'posts/index.html.erb' do

  let(:user){create(:user)}
  let(:another_user){create(:user)}
  let(:profile){create(:profile, :user_id => user.id)}
  let(:post){create(:post, :user_id => user.id)}
 
  before do
    assign(:user, user)
    assign(:post, post)
    assign(:profile, profile)

    posts = create_list(:post, 1)
    assign(:posts, posts)

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
            binding.pry
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
