require 'rails_helper'
require 'pry'

describe 'posts/_post.html.erb' do
  let(:user){ create(:user, :with_profile)}
  let(:friend){ create(:user, :with_profile)}
  let(:popular_post){ create(:post, :with_likes, likes_count: 5, user: user)}
  before do
    def view.current_user
      nil
    end
    def view.user_signed_in?
      false
    end
  end
  it 'displays the total number of likes' do
    # popular_post.reload
    render partial: 'post', locals: {post: popular_post}
    expect(rendered).to have_content('5 likes')
  end
  it 'displays the first few names of those who liked the post' do
    post = create(:post, user:  create(:user, :with_profile))
    post.likers << [user, friend]
    render partial: 'post', locals: {post: post}
    expect(rendered).to have_content(post.likers.second.first_name)
    expect(rendered).to have_content(post.likers.first.first_name)
  end
  context 'logged in' do
    before do
      assign(:user, user)
      def view.current_user
        @user
      end
      def view.user_signed_in?
        true
      end
    end
    it 'displays the unlike link if post is liked by user' do
      post = create(:post,  user: create(:user, :with_profile))
      post.likers << [user, friend]
      render partial: 'post', locals: {post: post}
      expect(rendered).to have_content("You and #{friend.full_name}")
    end
  end


end
