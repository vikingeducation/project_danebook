require 'rails_helper'


  describe "sessions/_navbar.html.erb" do
    before do
      user = create(:user)
      assign(:user, user)     
      
      def view.signed_in_user?
        true
      end
      def view.current_user
        @user
      end
    end
    #Happy
    it "shows SingOut link for a user" do
      render
      expect(rendered).to match ("Sign Out")
    end
    #Sad
    it "does not show login button to a user" do
      render
      expect(rendered).not_to match ("Sign In")
    end
     it "does not show Sign Up form to a user" do
      render
      expect(rendered).not_to match ("Password Confirmation")
    end
  end

  describe "sessions/_navbar_sign_up.html.erb" do
    before do
      user = create(:user)
      assign(:user, user)     
      
      def view.signed_in_user?
        false
      end
      def view.current_user
        
      end
    end
    #Happy
    it "shows SingIn link to a visitor" do
      render
      expect(rendered).to match ("Sign In")
    end
    it "shows login form to a visitor" do
      render
      expect(rendered).to match ("Password")
    end
    #Sad
    it "does not show profile" do
      render
      expect(rendered).not_to match ("Timeline")
    end



  end