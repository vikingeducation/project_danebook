require 'rails_helper'


describe 'posts/_post.html.erb' do

  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id)}
  let(:post_like) { create(:post_like, likeable_id: post.id, user_id: user.id) }

  before :each do
    @user = user
    @post = post
    def view.current_user
      @user
    end
  end

  describe "user does not like post" do

    it "like button is shown" do
      user
      controller.request.path_parameters[:user_id] = @user.id
      render 'post.html.erb', post: post, user: user

      expect(rendered).to have_content("Like")
    end

  end


  describe "user likes post" do

    it "unlike button is shown" do
      controller.request.path_parameters[:user_id] = @user.id
      render 'post.html.erb', post: post, user: user, likes: post_like

      expect(rendered).to have_content("Unlike")      

    end

  end

end