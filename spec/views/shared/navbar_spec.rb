require 'rails_helper'

describe "shared/_navbar.html.erb" do
  context "Sign in" do
    let(:user){ create(:user) }
    let!(:profile){ create(:profile, user: user) }
    before do
      def view.sign_in_user?
        true
      end

      @user = user
      def view.current_user
        @user
      end
    end

    it 'should see a Sign out button' do
      render

      expect(rendered).to match "Sign out"
    end

    it "should show the full name of the user" do
      render

      expect(rendered).to match "#{profile.first_name} #{profile.last_name}"
    end
  end

  context "Sign out" do
    before do
      def view.sign_in_user?
        false
      end
    end
    it 'should see a log in button' do
      render
      expect(rendered).to match "Come On!"
    end
  end
end