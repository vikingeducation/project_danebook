require "rails_helper"

describe "shared/_jumbotron.html.erb" do
  let(:user){ create(:user) }
  let(:other_user){ create(:user) }
  let(:profile){ create(:profile, user: user) }
  before{ [user, profile, other_user] }

  it "shows the add as friend button if you are logged in and in another user's page" do
    @other_user = other_user
    @user = user
    def view.user
      @user
    end
    def view.signed_in_user?
      true
    end
    def view.current_user
      @other_user
    end
    render

    expect(rendered).to match("Add as Friend")
  end

  it "does not show the add as friend button if you are the current user" do
    @user = user
    def view.user
      @user 
    end
    def view.signed_in_user?
      true
    end
    def view.current_user
      @user
    end
    render

    expect(rendered).not_to match("Add as Friend")
  end

end
