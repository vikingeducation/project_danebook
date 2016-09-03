require 'rails_helper'

describe "users/timeline.html.erb" do
  let(:user){create(:user)}
  before do
    def view.signed_in_user?
      true
    end
    @user = user
    def view.current_user
      @user
    end
    def view.correct_user?
      true
    end
  end
  it "shows the h1" do

    # get ready to set our instance variable



    # Actually set the instance variable.
    # This is identical to writing `@users = users`
    #   but is more "RSpec-like"



    # render the view
    render

    # Check that it contains our user's first name

    # ... HTML style
    expect(rendered).to have_text("Danebook")
  end


end
