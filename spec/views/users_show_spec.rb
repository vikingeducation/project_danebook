require 'rails_helper'

describe "users/show.html.erb" do

  before do
    user = create(:user)
    user.profile = build(:profile)
    assign(:user, user)
    def view.current_user
      @user
    end
    assign(:posts, [])
    assign(:post, Post.new)
  end

  it "shows some of the user's profile info" do
    render
    expect(rendered).to match("Fillydelphia")
  end

end