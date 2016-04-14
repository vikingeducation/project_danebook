require 'rails_helper'

describe 'shared/_general_navbar.html.erb' do 

  let(:user) { create(:user) }

  describe "user is logged in" do

    before do
      @user = user
      def view.current_user
        @user
      end
    end

    it "logout button is visible" do
      render
      expect(rendered).to have_content("Log Out")
    end

  end

  describe "user is logged out" do

    before do
      def view.current_user
        nil
      end
    end

    it "login button is visible" do
      render
      expect(rendered).to have_content("Log In")
    end

  end




end