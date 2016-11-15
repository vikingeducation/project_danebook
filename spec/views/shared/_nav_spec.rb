require 'rails_helper'

describe 'shared/_nav.html.erb' do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}

  before do
    @user = user
    def view.current_user
      @user
    end

    def view.signed_in_user?
      true
    end
  end

  describe 'partial' do
    it 'renders the search form when the user is logged in' do
      render :partial => 'shared/nav'
      expect(rendered).to have_link('Sign Out')
    end

    it 'renders the login form when the user is logged out' do
      @user = nil
      render :partial => 'shared/nav'
      expect(rendered).to have_content('Remember me?')
    end
  end 
end

