require 'rails_helper'

describe 'shared/_form.html.erb' do
  let(:male){create(:male)}
  let(:user_one){create(:user, :gender => male)}
  let(:user_two){create(:user, :gender => male)}
  let(:friend_request){create(:friend_request, :initiator => user_two, :approver => user_one, :approved => true)}
  let(:friendship_persisted){create(:friendship, :initiator => user_two, :approver => user_one)}
  let(:friendship_new_record){build(:friendship, :initiator => user_two, :approver => user_one)}

  before do
    @user = user_one
    def view.current_user
      @user
    end

    def view.signed_in_user?
      true
    end
  end

  describe 'button' do
    it 'is unfriend when friendship exists' do
      friend_request
      render :partial => 'friendships/form', :locals => {:friendship => friendship_persisted}
      expect(rendered).to have_content('Unfriend')
    end
  end 
end








