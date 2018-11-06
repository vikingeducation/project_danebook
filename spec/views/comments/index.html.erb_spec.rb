require 'rails_helper'

describe 'comments/index.html.erb' do

  let(:user){ create(:user) }
  let(:user_profile){ create(:profile, user_id: user.id) }
  let(:user_post){ create(:post, user_id: user.id) }
  let(:post_comments){ create_list(:comment, 3, commentable_id: user_post.id, user_id: user.id, commentable_type: "Post") }

  before do
    @user = user
    @user_profile = user_profile
    @user_post = user_post
    @comments = post_comments
    def view.find_current_page_user
      @user
    end
    def view.current_user
      @user
    end
    def view.comments
      @comments
    end

    controller.request.path_parameters[:user_id] = @user.id
    controller.request.path_parameters[:post_id] = @user_post.id
  end

  it 'lists all comments for post' do
    render
    expect(rendered).to have_content(@comments.first.body)
    expect(rendered).to have_content(@comments.last.body)
  end

  it 'has like link if user has not liked comment' do
    render
    expect(rendered).to have_link('Like')
  end

  it 'has unlike link if user has previously liked comment' do
    @like = Like.create(user_id: @user.id, likable_id: @comments.first.id, likable_type: 'Comment')
    render
    expect(rendered).to have_link('Unlike')
  end

end
