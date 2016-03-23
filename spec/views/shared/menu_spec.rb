require 'rails_helper.rb'

describe "shared/_menu.html.erb" do
  context "Logged in User viewing own menu" do

    let(:user) { create(:user) }
    let(:profile) { create(:profile, user: user) }

    before do

      assign(:user, user)
      assign(:profile, profile)

      def view.current_user
        @user
      end

      def view.signed_in_user?
        true
      end

    end

    it "renders 'Edit Profile' CTA for user viewing his own menu" do
      render
      expect(rendered).to match "Edit Profile"
    end

  end

  context "Logged in User viewing another's profile menu" do

    let(:user) { create(:user) }
    let(:profile) { create(:profile, user: user) }
    let(:user_2) { create(:user)}
    let(:profile_2) { create(:profile, user: user_2) }

    before do

      assign(:user, user)
      assign(:profile, profile_2)

      def view.current_user
        @user
      end

      def view.signed_in_user?
        true
      end

    end

    it "does not render 'Edit Profile' CTA when viewing other profiles" do
      render
      expect(rendered).to_not match "Edit Profile"
    end

  end
end
