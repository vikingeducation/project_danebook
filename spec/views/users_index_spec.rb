require 'rails_helper'

describe "users/index.html.erb" do

  context "a search is performed for a specific user's first name" do

    before do
      user = create(:user)
      assign(:user, user)
      users = [user, create(:user, :diff_user)]
      assign(:users, users)
      def view.current_user
        @user
      end
    end

    it "displays a link to that user" do
      render
      expect(rendered).to match("Bill Dobbs")
    end

  end

end