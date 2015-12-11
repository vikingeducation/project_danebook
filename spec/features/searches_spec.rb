require 'rails_helper'

describe 'Searches' do
  let(:female){create(:female)}
  let(:users){create_list(:user, 5, :gender => female)}
  let(:user){users.first}

  before do
    visit login_path
    sign_in(user)
    visit search_path
  end

  describe 'listing' do
    it 'shows all the users with a name that is like the query', :js => true do
      submit_search(user.name)
      expect(page).to have_content(user.name)
    end

    it 'does not show users with a name unlike the query', :js => true do
      submit_search(user.name)
      expect(page).to_not have_content(users.last.name)
    end
  end
end

