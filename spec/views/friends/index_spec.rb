require 'rails_helper'

describe 'friends/index.html.erb' do
  let(:user){ create(:user) }
  let(:profile){ create(:profile, user:user) }
  before do
    def view.authorized_user?
      true
    end

    @user = user
    def view.current_user
      @user
    end
  end

  it "shows one box for each friend" do
    assign(:user, user)
    assign(:profile, profile)
    7.times do 
      to_friend = create(:user)
      create(:profile, user: to_friend)
      user.friended_users << to_friend
    end
    user.reload
    visit(user_friends_path(user))
    #render
    page.assert_selector('.friend-box', :count => 7)
    #expect(page.all(:css, '.friend-box').size).to eq(7)
  end

  it "shows the number of friends" do

  end

end