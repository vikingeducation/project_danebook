require 'rails_helper'

describe 'friend_requests/_form.html.erb' do
  let(:male){create(:male)}
  let(:user_one){create(:user, :gender => male)}
  let(:user_two){create(:user, :gender => male)}
  let(:friend_request_this_user){create(:friend_request, :initiator => user_two, :approver => user_one)}
  let(:friend_request_other_user){create(:friend_request, :initiator => user_one, :approver => user_two)}

  before do
    @user = user_one
    def view.current_user
      @user
    end

    def view.signed_in_user?
      true
    end
  end

  describe 'button or button group' do
    it 'is accept and reject when a request is pending approval by this user' do
      render :partial => 'friend_requests/form', :locals => {:friend_request => friend_request_this_user}
      expect(rendered).to have_content('Accept')
    end

    it 'is cancel when a request is pending approval by another user' do
      render :partial => 'friend_requests/form', :locals => {:friend_request => friend_request_other_user}
      expect(rendered).to have_content('Cancel')
    end
  end 
end

