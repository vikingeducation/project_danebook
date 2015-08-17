require 'rails_helper'


describe "shared/_navbar.html.erb" do

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
      render 'shared/navbar'
    end


    it "displays Log Out link" do
      expect(rendered).to have_link('Log Out')
    end

    it "displays the current user's email" do
      expect(rendered).to have_link(user.email)
    end

  end



  context "when logged out" do

    before do
      def view.signed_in_user?
        false
      end

      def view.current_user
        nil
      end
    end


    it "displays the log-in form" do
      render 'shared/navbar'
      expect(rendered).not_to have_link('Log Out')
      expect(rendered).to have_field('Email')
      expect(rendered).to have_button('Log In')
    end

  end

end