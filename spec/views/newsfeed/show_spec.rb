require 'rails_helper'


describe "newsfeeds/show.html.erb" do

  context "in Recently Active friends list" do

    let(:user) { create(:user) }
    let(:poster) { create(:user) }

    before do
      create_list(:post, 2, :poster => poster)
      user.friended_users << poster

      assign(:user, user)
      assign(:posts, poster.posts)
      assign(:friends, user.friended_users)

      def view.signed_in_user?
        true
      end

      def view.current_user
        @user
      end

    end

    it "should not display the same user multiple times" do
      render
      expect(rendered).to have_css('.recently-active', text: poster.profile.full_name, count: 1)
    end

  end

end
