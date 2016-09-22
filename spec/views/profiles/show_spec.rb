require 'rails_helper'

describe "profiles/show.html.erb" do

  let(:profile){ create(:profile, :with_attributes ) }
  let(:user){ create(:user, :profile => profile) }

  before do
    @profile = profile
    @user = user
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

    it "shows the first name of profile" do
      render
      expect(rendered).to have_content(@first_name)
    end

  end

end