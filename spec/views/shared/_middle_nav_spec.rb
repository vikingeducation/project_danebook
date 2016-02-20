require 'rails_helper'


describe 'shared/_middle_nav.html.erb' do

  let(:friender) { create(:user) }
  let(:friend) { create(:user) }
  let(:profile) { create(:profile, user_id: friend.id) }

  before do
    @friender = friender
    def view.current_user
      @friender
    end
  end

  describe "user is friends with current profile's user" do

    let(:friending) { create(:friending, friender_id: friender.id, friend_id: friend.id)}

    it "'Remove Friend' button is visible" do
      friending
      controller.request.path_parameters[:user_id] = friend.id
      render 'shared/middle_nav.html.erb', profile: profile

      expect(rendered).to have_css("[value='Remove Friend']")
    end

  end



  describe "user is not friends with current profile's user" do

    it "'Add Friend' button is visible" do
      controller.request.path_parameters[:user_id] = friend.id
      render 'shared/middle_nav.html.erb', profile: profile

      expect(rendered).to have_css("[value='Add Friend']")
    end
    
  end



end