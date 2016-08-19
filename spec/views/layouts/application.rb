require 'rails_helper'

describe "layouts/application" do

  let(:profile){ create(:profile, :with_attributes ) }
  let(:user){ create(:user, :profile => profile) }

  context "when a user is logged in" do

    before do

      @profile = profile
      @user = user

      def view.signed_in_user?
        true
      end
      def view.current_user
        @user
      end
    end
  end
end