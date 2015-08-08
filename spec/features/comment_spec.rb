require 'rails_helper'
  feature "Comment" do
    let(:user){create(:user)}
    let(:profile){create(:profile, :user_id => user.id)}
    before do
      sign_in(user)
    end

    context "work with comments" do
      let!(:post){create(:post, :user_id => user.id)}
     
      scenario "can comment on comment" do 
        visit user_posts_path(user.id)
        text="Well commented comment"
        find(:id, 'comment_body').set(text)
        click_on("Comment")
        expect(page).to have_content(text)
      end

      scenario "can unlike comment" do
        visit user_posts_path(user.id)
        save_and_open_page
        click_on("Like")
        expect(page).to have_content("Unlike")
      end 

    end

  end