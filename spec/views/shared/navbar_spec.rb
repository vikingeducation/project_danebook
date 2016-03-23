require 'rails_helper.rb'

describe "shared/_navbar.html.erb" do

  context "Visitor" do

    before do

      def view.current_user
        false
      end

      def view.signed_in_user?
        false
      end

    end

    it "shows login form for visitor" do
      render
      expect(rendered).to match "Login"
    end
  end

  context "Logged in User" do
    let(:user) { create(:user) }
    before do

      assign(:user, user)

      def view.current_user
        @user
      end

      def view.signed_in_user?
        true
      end

    end

    it "renders personalized info/links for signed in user" do
      render
      expect(rendered).to match "Logout"
    end
  end
end
