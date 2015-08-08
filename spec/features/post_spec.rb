require 'rails_helper'
feature 'Post' do

  context "on user timeline" do
      let(:user){create(:user)}
      let!(:post){create(:post, :author => user)}

      before do
        sign_in(user)
        visit  user_posts_path(user.id)
      end


      scenario "can be created" do
        expect(page).to have_button("Post")
      end

      scenario "can post on its own timeline" do
        #fill_in "Tell the world something...", with: "New post coming!"
        find(:id, 'post_body').set("New post coming!")
        click_button "Post"
        page.has_selector?(:xpath, "//input[@id='post_body']")
        expect(page).to have_content "New post coming!"
      end
      
      # scenario "can delete its own post" do 
      #   expect(page).to have_content "#{post.body}"
      #   click_link "Delete"
      # end

      scenario "can comment on post" do
        text="New comment coming!"
        find(:id, 'comment_body').set(text)
        click_button "Comment"
        expect(page).to have_content text
      end

      scenario "can like post"

      scenario "can unlike post"
  end
end