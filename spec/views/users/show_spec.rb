# spec/views/users/show_spec.rb
require 'rails_helper'


describe "users/show.html.erb" do
  it "A logged in user can see their profile page" do
    user = create(:user)
    profile = create(:profile, user: user)

    assign(:profile, profile) 

      def view.signed_in_user?
        true
      end
      def view.current_user
        @user
      end
     def current_user
      @current_user = @user
     end
     def sign_in(user)
      session[:user_id] = user.id
      @current_user = user
      true
    end

    # render the view
    render

    expect(rendered).to have_content("Words to Live By")
    # expect(rendered).to have_content(profile.firstname)
  end

  it "Verify that a User that is logged in can  go to the edit profile page" do
    user = create(:user)
    profile = create(:profile,:user_id => user.id)


     # Override our helper methods
      def view.signed_in_user?
        false
      end
      def view.current_user
        @user
      end

    # render the view
    render

    # ... HTML style
    expect(rendered).to have_content("**hidden**")
  end
end
