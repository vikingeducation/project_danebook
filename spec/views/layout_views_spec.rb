require 'rails_helper'

describe 'shared/_nav.html.erb' do
  let(:user){ create(:user) }

  context 'when signed in' do
    before do
      cookies[:auth_token] = user.auth_token
      @user = user
      def view.signed_in_user?
        true
      end

      def view.current_user
        @user
      end

      render
    end

    it 'nav search bar is present' do
      expect(rendered).to have_selector("input", class: 'search') 
    end

    it 'name is displayed on nav' do
      expect(rendered).to have_content("#{user.first_name}")
    end

    it 'logout link on nav' do
      expect(rendered).to have_link('Log Out')
    end
  end

  context 'not signed in' do
    before do
      def view.signed_in_user?
        false
      end
      
      render

    end

    it 'log in form is present' do
      expect(rendered).to have_selector("input", id: 'email')
    end
  end



end