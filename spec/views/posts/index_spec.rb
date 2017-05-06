require 'rails_helper'

describe 'posts/index.html.erb' do
  let(:user){ create(:user, :with_profile) }
  let(:posting){ create(:post, user: user)}
  context 'logged out' do
    before do
      assign(:user, user)
      assign(:post, build(:post,  user: user))
      def view.current_user
        nil
      end
      def view.user_signed_in?
        false
      end
    end
    it 'shows the new form post' do
      render
      expect(rendered).to match('name="post\[body\]"')
    end
    it 'shows a user\'s posts' do
      assign(:posts, create_list(:post, 3, user: user))
      render
      expect(rendered).to have_text(user.posts.last.body)
      expect(rendered).to have_text(user.posts.first.body)
      expect(rendered).to have_text(user.posts.second.body)
    end

  end
end
