require "rails_helper"

describe "users/show.html.erb" do
  let(:user){ create(:user) }
  let(:other_user){ create(:user) }
  let(:profile){ create(:profile, user: user) }
  before{ [user, profile, other_user] }

  it "shows the edit profile button if it's the same user" do
    @user = user
    def view.signed_in_user?
      true
    end
    def view.current_user
      @user
    end
    render

    expect(rendered).to match("Edit your profile")
  end

  it "does not show the edit profile button if it's not the same user" do
    @user = user
    def view.signed_in_user?
      false
    end
    def view.current_user
    end

    render

    expect(rendered).not_to match("Edit your profile")
  end

end
