require 'rails_helper'

describe "users/new.html.erb" do


  it "shows the welcome page for new users" do
    assign(:user, User.new)
    render
    expect(rendered).to match('<h1>Sign Up</h1>')
  end

end