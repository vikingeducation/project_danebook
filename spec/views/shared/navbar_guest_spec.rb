require 'rails_helper'


describe "shared/_navbar_guest.html.erb" do

  let(:user) { create(:user) }


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
      render 'shared/navbar_guest'
      expect(rendered).not_to have_link('Log Out')
      expect(rendered).to have_field('Email')
      expect(rendered).to have_button('Log In')
    end

  end

end