require 'rails_helper'

describe 'users/show.html.erb' do

  let(:user){create(:user)}
  let(:profile){create(:profile, birth_day: 1, birth_month: 1, birth_year: 2000, user_id: user.id)}

  before do
    assign(:user, user)
    assign(:profile, profile)

    def view.signed_in_user?
      true
    end

    def view.current_user
      @user
    end
  end

  it "User sees the correct format of date of birth" do
    render
    expect(rendered).to have_content("1st January 2000")
  end


end
