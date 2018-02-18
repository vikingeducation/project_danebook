require 'rails_helper'
require 'pry'

describe 'layouts/application.html.erb' do

  let(:user){create(:user)}
  let(:profile){create(:profile, :user_id => user.id)}

  before do
    assign(:user, user)
    assign(:profile, profile)
  end

  context "the user is logged-in" do
    before do
      def view.signed_in_user?
        true
      end

      def view.current_user
        @user
      end
    end

    it "User sees a 'Logout' link with his name in navbar" do
      render

      expect(rendered).to have_selector("a[href=\'#{logout_path}\']", :text => "#{profile.first_name} Log Out")
    end
  end

  context "the user is NOT logged-in" do
    before do
      def view.signed_in_user?
        false
      end

      def view.current_user
        nil
      end
    end

    it "User see a 'Login' link" do
      render
      # binding.pry
      expect(rendered).to include("Log in")
      expect(rendered).not_to include("Log Out")
    end
  end

end
