require 'rails_helper'

describe 'posts/_post.html.erb' do

  context 'displays post' do
    before do
      @user = create(:user)
      @post = create(:post, user: @user)
      def view.post
        @post
      end

      def view.current_user
        @user
      end

    end

    it 'should show post body' do
      render
      expect(response).to match("something in post body")
    end

    describe 'should show likes count' do

      it 'should say "You like this." if user liked post'
      it "should display link to a user's profile who liked post"
      it "should display the remaining count of likes"
    end

  end

end
