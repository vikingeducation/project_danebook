require 'rails_helper'

feature "Timeline" do 
  let(:user){create(:user)}

  before do
    feature_sign_in(user)
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
 end  
end