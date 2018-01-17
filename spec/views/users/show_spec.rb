# spec/views/users/show_spec.rb
require 'rails_helper'


describe "users/show.html.erb" do
  let(:user){create(:user)}
  let(:profile){ create(:profile, user: user)}
  
  before do
    @user = user
    @profile = profile

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
  end

  it "A logged in user can see their profile page" do
    # render the view
    render

    expect(rendered).to have_content("Words to Live By")
    expect(rendered).to have_content(profile.firstname)
  end

end
