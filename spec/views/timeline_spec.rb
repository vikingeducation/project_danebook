require 'rails_helper'
describe "posts/index.html.erb" do
  let(:render_with_layout) { render template: 'posts/index.html.erb', layout: 'layouts/application' }
  context "logged in user" do # visitors are forbidden access
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:profile) { create(:profile, user: user1)}
    let(:post) { build(:post, user: user1) }
    before do
      # @profile.user1 = user1
      assign(:profile, profile)
      assign(:user, user1)
      assign(:post, post)
      assign(:posts, [])
      @user = user1
      def view.current_user
        @user
      end
    end

    it "shows the number of friends" do

      user1.friended_users << user2

      render

      within('.badge') do
        expect(rendered).to include('1')
      end
    end

  end
end
