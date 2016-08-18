require 'rails_helper'

describe 'users/show.html.erb' do
  let(:posts) { create_list(:post, 5) }
  let(:profile) { create(:profile) }
  let(:user) { create(:user, profile: profile, posts: posts) }
  before do

  end
  context "looking at current user's page" do
    before do
      @user = user
      assign(:user, user)
      assign(:posts, posts)
      login(user)
      def view.current_user
        @user
      end
    end
    it "displays" do
      stub_template "posts/_form.html.erb" => "posts form"
      render
      expect(rendered).to match('posts form')
    end
  end

  context "looking at different user's page" do

  end


end
