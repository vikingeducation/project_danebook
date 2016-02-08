require 'rails_helper'

describe 'shared/_navbar.html.erb' do

  context 'logged out' do

    before do
      def view.current_user
        false
      end
    end

    it 'should not show username if user not logged in' do
      new_user = create(:user)
      render
      expect(rendered).to_not match(new_user.first_name)
    end

    it 'should show login form if user not logged in' do
      render
      expect(rendered).to match("Log In")
    end

  end

  context 'logged in' do
    let(:user){ create(:user) }

    before do
      @user = user
      def view.current_user
        @user
      end
    end

    it 'should show username if user not logged in' do
      render
      expect(rendered).to match(user.first_name)
    end

  end
end
