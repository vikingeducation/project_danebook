require 'rails_helper'

describe "posts/_post_feed.html.erb" do


  let(:other_user){ create(:user) }
  let(:current_user){ create(:user) }
  before(:each) do
    allow(view).to receive(:current_user).and_return(current_user)
  end

  it "shows the post author's first name" do
    posts = create_list(:post, 2)
    assign(:posts, posts)

    # render the view
    render
    # ... CSS style
    expect(rendered).to have_selector("a[href=\"#{user_path(posts.first.user)}\"]", :text => "#{posts.first.user.name}")
  end



  it "shows no sentence about likes if no one liked a post" do
    posts = create_list(:post, 1)
    assign(:posts, posts)

    # render the view
    render
    # ... CSS style
    expect(rendered).not_to have_content("liked this post.")
  end


  it "shows if current user liked a post" do
    posts = create_list(:post, 1)
    posts.first.users_who_liked << view.current_user
    assign(:posts, posts)

    # render the view
    render
    # ... CSS style
    expect(rendered).to have_content("You liked this post.")
  end

  it "shows if another user liked a post" do
    posts = create_list(:post, 1)
    posts.first.users_who_liked << other_user
    assign(:posts, posts)

    # render the view
    render
    # ... CSS style
    expect(rendered).to have_content("#{other_user.name} liked this post.")
  end

  it "shows you and another user liked a post" do
    posts = create_list(:post, 1)
    posts.first.users_who_liked << other_user
    posts.first.users_who_liked << current_user
    assign(:posts, posts)

    # render the view
    render
    # ... CSS style
    expect(rendered).to have_content("You and #{other_user.name} liked this post.")
  end

  it "Names two users at most, plus the remaining number who liked a post" do
    posts = create_list(:post, 1)
    posts.first.users_who_liked << other_user

    other_other_user = create(:user)
    posts.first.users_who_liked << other_other_user

    5.times{ posts.first.users_who_liked << create(:user) }
    assign(:posts, posts)

    # render the view
    render
    # ... CSS style
    expect(rendered).to have_content("#{other_user.name}, #{other_other_user.name} and 5 other users liked this post.")
  end


  it "Always includes You even if many users liked a post" do
    posts = create_list(:post, 1)
    posts.first.users_who_liked << current_user
    posts.first.users_who_liked << other_user

    5.times{ posts.first.users_who_liked << create(:user) }
    assign(:posts, posts)

    # render the view
    render
    # ... CSS style
    expect(rendered).to have_content("You, #{other_user.name} and 5 other users liked this post.")
  end


end