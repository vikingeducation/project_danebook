require 'rails_helper'

describe "users/show.html.erb" do

  let(:user) { create(:user) }

  before do
    assign(:user, user)
    def view.current_user
      @user
    end
  end

  it "shows the user about page" do
    render
    expect(rendered).to match('<h2>About</h2>')
  end

  it "shows an edit profile button if you are the viewing your own about page" do
    render
    expect(rendered).to match('Edit Your Profile')
    expect(rendered).to match('Modify Account')
  end

  it "doesn't show an edit profile button if you are viewing anyone else's page" do
    assign(:another_user, create(:user))
    def view.current_user
      @another_user
    end
    # Now we are rendering @user's about page, but the current user is @another_user
    render
    expect(rendered).not_to match('Edit Your Profile')
    expect(rendered).not_to match('Modify Account')
  end

end