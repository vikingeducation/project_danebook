require 'rails_helper'


  describe "profiles/_menu.html.erb" do
    before (:each) do
      user = create(:user)
      assign(:user, user)     
      assign(:profile, user.profile)
      def view.active
        "About"
      end
      def view.signed_in_user?
        true
      end
      @user=user
      def view.current_user
        @user
      end
    end

    it "shows menu" do    
        render
        expect(rendered).to match ("Edit Profile")
    end
  end

  describe "profiles/show.html.erb" do
    before (:each) do
      user = create(:user)
      assign(:user, user)     
      assign(:profile, user.profile)
      def view.active
        "About"
      end
      def view.signed_in_user?
        true
      end
      @user=user
      def view.current_user
        @user
      end
    end
  
    it "should show profile info" do
      render
      expect(rendered).to match ('<h3>About Me</h3>')
    end

    it "should show profile info" do
      render
      expect(rendered).to match ('Basic Information')
    end
end



 

