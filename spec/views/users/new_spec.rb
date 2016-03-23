require 'rails_helper.rb'

describe "users/new.html.erb" do
  it "shows the correct signup for visitor" do
    user = User.new
    profile = Profile.new
    assign(:user, user)
    assign(:profile, profile)

    render

    expect(rendered).to match "First Name"
    expect(rendered).to match "Password Confirmation"
  end
end
