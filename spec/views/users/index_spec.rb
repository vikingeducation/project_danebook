require 'rails_helper'

describe "users/index.html.erb" do

  let(:profile){ create(:profile, :with_attributes ) }
  let(:user){ create(:user, :profile => profile) }

  before do
    assign(:profile, profile)
    assign(:user, user)
  end

  context "when visitor is not signed in" do

    before do 
      def view.signed_in_user?
        false
      end
    end

    it "will show login" do 
      render :template => 'users/index', :layout => 'layouts/application'
      expect(rendered).to match(/Log In/)
    end

  end

  context "when user is signed in" do

    before do
      def view.signed_in_user?
        true
      end

      def view.current_user
        @user
      end
    end

    it "shows the logout link" do 
      render :template => 'users/index', :layout => 'layouts/application'
      expect(rendered).to match(/Logout/)
    end
  end

end