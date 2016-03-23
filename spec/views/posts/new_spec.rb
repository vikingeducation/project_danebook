# spec/views/users/index_spec.rb
require 'rails_helper'

describe "posts/new.html.erb" do

  let(:users){create_list(:user, 2)}
  let(:profile){create(:profile, user: users[0])}
  let(:posts){create_list(:post, 5, user: users[0])}
  
  let(:like){create(:like,
                    user_id: users[1].id,
                    likeable_id: posts[0].id, 
                    likeable_type: "Post")}

  before :each do
    def view.signed_in_user?
      true
    end

    def view.current_user
      @user
    end

    def view.current_user_view?
     true
    end  
  end

  it "shows all posts for the user" do
    users
    posts

    assign(:user, users[0])     
    assign(:posts, posts) 
    assign(:profile, profile)
    assign(:post, build(:post))

    render template: 'posts/new' , layout: 'layouts/application'

    expect(rendered).to have_css('.post-body', count: 5)

  end

  it "shows Unlike for the post liked" do
    users
    posts
    like
    assign(:user, users[0])     
    assign(:posts, posts) 
    assign(:profile, profile)
    assign(:post, build(:post))
    #byebug 
    render template: 'posts/new' , layout: 'layouts/application'

    expect(rendered).to have_content('Unlike', count: 1)

  end

  it "renders new post form for the authorized user" do
    #users
    #posts

    assign(:user, users[0])     
    assign(:posts, posts) 
    assign(:profile, profile)
    assign(:post, build(:post))

    render template: 'posts/new' , layout: 'layouts/application'

    expect(rendered).to have_css('.post-button', count: 1)

  end


  it "does not render new post form for post user not = current  user" do
    
    def view.current_user_view?
     false
    end 

    users
    posts


    assign(:user, users[0])     
    assign(:posts, posts) 
    assign(:profile, profile)
    assign(:post, build(:post))

    render template: 'posts/new' , layout: 'layouts/application'

    expect(rendered).to have_css('.post-button', count: 0)

  end

  it "shows all posts for post user who is not the current user" do
    def view.current_user_view?
     false
    end 
    #users
    #posts

    assign(:user, users[0])     
    assign(:posts, posts) 
    assign(:profile, profile)
    assign(:post, build(:post))

    render template: 'posts/new' , layout: 'layouts/application'

    expect(rendered).to have_css('.post-body', count: 5)

  end 

end