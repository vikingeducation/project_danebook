require 'rails_helper'

describe 'posts/index.html.erb' do

  let(:user){ create(:user) }
  let(:user_profile){ create(:profile, user_id: user.id) }
  let(:post){ create(:post, user_id: user.id) }

  before do
    @user = user
    @user_profile = user_profile
    @post = post
    def view.find_current_page_user
      @user
    end
    def view.current_user
      @user
    end
    controller.request.path_parameters[:user_id] = @user.id
  end

  context 'user has posts' do

    it 'shows users name' do
      render
      expect(rendered).to match(@user_profile.name)
    end

    it 'renders new post form' do
      render
      expect(rendered).to match('<form class="new_post"')
    end

    it 'lists all users posts' do
      user_posts = create_list(:post, 5, user_id: @user.id)
      render
      expect(rendered).to have_content(user_posts.first.body)
      expect(rendered).to have_content(user_posts.last.body)
    end

    it 'has like link' do
      post = Post.create(user_id: @user.id, body: "This is a really cool post")
      render
      expect(rendered).to have_link('like')
    end

    it 'has unlike link if post previously liked' do
      post = Post.create(user_id: @user.id, body: "This is a really cool post")
      like = Like.create(user_id: @user.id, likable_id: @post.id, likable_type: 'Post')
      render
      expect(rendered).to have_link('unlike')
    end

  end

  context 'user has no posts' do

    it 'still renders new post form if user has no posts' do
      render
      expect(rendered).to match('<form class="new_post"')
      expect(rendered).not_to match('<div class="post post-with-comment">')
    end

  end


end
