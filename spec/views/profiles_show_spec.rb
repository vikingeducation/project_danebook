require 'rails_helper'

describe "profiles/show.html.erb" do

  before do
    user = create(:user)
    user.profile = build(:profile)
    assign(:user, user)
  end

  context "current user is viewing their own profile" do

    before do
      def view.current_user
        @user
      end
    end

    it "displays their profile information" do
      render
      expect(rendered).to match("Fillydelphia")
    end

    it "displays a link to edit profile" do
      render
      expect(rendered).to match("Edit Profile")
    end
  end

  context "current user is viewing someone else's profile" do

    before do
      diff_user = create(:user, :diff_user)
      assign(:current_user, diff_user)
      def view.current_user
        @current_user
      end
    end

    it "display's that user's profile information" do
      render
      expect(rendered).to match("Fillydelphia")
    end

    it "doesn't display a link to edit profile" do
      render
      expect(rendered).not_to match("Edit Profile")
    end

  end

end