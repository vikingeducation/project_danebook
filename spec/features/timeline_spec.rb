require 'rails_helper'

feature "Timeline" do 
let(:user){create(:user)}

  before do
    sign_in(user)
  end


context "posts" do

  context "create" do
    scenario 'Should be able to write posts on your own timeline' do
       fill_in 'post_body', with: "Test Post"
       expect{click_button "Post"}.to change(Post, :count).by(1)
       expect(page).to have_content "Test Post"
    end

    scenario 'should not be able to submit a blank post' do
       fill_in 'post_body', with: ""
       expect{click_button "Post"}.to change(Post, :count).by(0)
       expect(page).not_to have_content "Test Post"
    end
  end

#NOT YET WORKING
  context "destroy" do

     scenario 'should be able to destroy a post' # do
    #   post = create(:post)
    #   user = post.user
    #   profile = post.profile
    #   user.profile = post.profile
    #   binding.pry
    #   visit profile_timeline_path(post.profile)
    #   save_and_open_page
    #   expect(page).to have_content(post.body)

    #   p Post.count
    #   expect(page).to have_content("Delete")
    #   click_link "Delete"
    #   expect(page).to have_content("Delete")

    #   # expect{click_link "Delete"}.to change(Post, :count).by(-1)
    #   p Post.count
      
    # end
  end
end

  
end