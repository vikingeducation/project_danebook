require 'rails_helper'

describe 'users/index.html.erb' do
  let(:user){ create(:user, :with_profile)}
  before do
    assign(:user, user)
    assign(:term, 'f')
    def view.current_user
      @user
    end
    def view.user_signed_in?
      true
    end
  end
  it 'shows the correct number of search results' do
    assign(:users, [create(:user, :with_profile, first_name: 'afa'), create(:user, :with_profile, last_name: 'faa'), create(:user, :with_profile, first_name: 'aaf')])
    render
    expect(rendered).to have_content('Showing 3 users')
    assign(:users, [])
    render
    expect(rendered).to have_content('Showing 0 users')
  end
end
