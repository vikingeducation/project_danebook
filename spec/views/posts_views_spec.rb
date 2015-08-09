require 'rails_helper'


  describe "posts/index.html.erb" do
    before do
      user = create(:user)
      assign(:user, user) 
      post = create(:post) 
      assign(:post, post) 
      new_post = create(:post)
      assign(:new_post, new_post )   
      assign(:posts, [post, new_post] ) 
      assign(:profile, user.profile)   
      
      def view.signed_in_user?
        true
      end
      def view.current_user
        @user
      end
    end

    it "shows new post form" do
      render
      expect(rendered).to match ("Tell the world something...")
    end

    it "shows comment form" do
      render
      expect(rendered).to match ("Write a comment...")
    end
    it "shows photos block link" do
      render
      expect(rendered).to have_selector("a[href=\"photos.html\"]", :text => "See More Photos")
    end
    

  end