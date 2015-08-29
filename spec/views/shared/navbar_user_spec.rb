require 'rails_helper'


describe "shared/_navbar_user.html.erb" do

  let(:user) { create(:user) }



  context "when logged in" do

    before do

      def view.signed_in_user?
        true
      end

      def view.current_user
        @user
      end

      assign(:user, user)
      render 'shared/navbar_user'
    end


    it "displays Log Out link" do
      expect(rendered).to have_link('Log Out')
    end

    it "displays the current user's image" do
      expect(rendered).to have_css('#navbar-photo')
    end

  end


end