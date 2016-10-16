require 'rails_helper'

describe 'users/about.html.erb' do
  describe 'logged in user checking' do
    before do
      @profile = create(:profile)
      @user    = @profile.user
      def view.current_user_page
        true
      end
    end
    it "shows the about page" do
      render
      expect(rendered).to match('Edit your profile</a>')
      expect(rendered).to match('<p class="col-xs-8">October 15th, 2016</p>')
    end
  end

  describe 'logged out user checking' do
    before do
      @profile = create(:profile)
      @user    = @profile.user
      def view.current_user_page
        false
      end
    end
    it "shows the about page" do
      render
      expect(rendered).not_to match('Edit your profile</a>')
      expect(rendered).to match('<p class="col-xs-8">October 15th, 2016</p>')
    end
  end
end