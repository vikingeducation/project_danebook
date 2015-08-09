require 'rails_helper'

describe 'shared/_post.html.erb' do

  context 'like count display' do
    before do
      @user = create(:user)
      @post = create(:post, user: @user)

      def view.current_user
        @user
      end

    end

    it 'should show "Be the first to like this." if post has no likes' do
      render
      expect(response).to match("Be the first to like this.")
    end
  end

end
