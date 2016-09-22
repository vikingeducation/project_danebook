require 'rails_helper'

describe "users/new.html.erb" do 
  let(:user){build(:user)}
  let(:user2){create(:user)}

  context "signed in" do 
    before do 
      def view.signed_in_user?
        true
      end
      @user = user2
      def view.current_user
        @user
      end
    end

    it "will show welcome text" do
      render :template => 'users/new', :layout => 'layouts/application'
      expect(rendered).to have_content(/Welcome/)
    end
  end

end