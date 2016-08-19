require 'rails_helper'

describe "users/index.html.erb" do 
  let(:user) {create(:user)}
  let(:user2) {create(:user)}

  it "shows the search query" do 
    users = [user, user2]
    assign(:users, users)
    render
    expect(rendered).to match(/#{user.first_name}/)
  end

  it "does not show any user for an empty search query" do 
    users = []
    assign(:users, users)
    render
    expect(rendered).to_not match(/#{user.first_name}/)
  end

end
