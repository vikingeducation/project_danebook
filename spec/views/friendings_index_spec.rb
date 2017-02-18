require 'rails_helper'

describe "friendings/index.html.erb" do

  before do
    user = create(:user)
    assign(:user, user)
    def view.current_user
      @user
    end
  end

  context "current user has no friends" do

    it "advises the user to make friends" do
      assign(:friends, [])
      render
      expect(rendered).to match("NO FRIENDS")
    end

  end

  context "current user has a friend" do

    it "displays a link to that friend's timeline" do
      friends = [create(:user, :diff_user)]
      assign(:friends, friends)
      render
      expect(rendered).to match(friends[0].full_name)
    end

  end

end