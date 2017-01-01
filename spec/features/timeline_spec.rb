require 'rails_helper'

feature "Likes" do
  let(:user) { create(:user) }
  before do
    user.profile = create(:profile)
    sign_in(user)
  end

  context "user with a post" do
    let(:post) { create(:post) }
    before do
      user.posts << post
      user.save!
      visit root_path
    end

    scenario "where user can like the post" do
      page.find('.like-this').click
      expect(page).to have_css('.unlike-this')
    end

    context "where the post is previously liked" do
      before do
        post.likes << create(:post_like, user_id: user.id)
        visit root_path
      end

      scenario "where user can unlike the post" do
        page.find('.unlike-this').click
        expect(page).to have_css('.like-this')
      end
    end

    context "where the post has a comment" do
      let(:comment) { create(:comment, user_id: user.id) }
      before do
        post.comments << comment
        visit root_path
      end
      scenario "the user can like the comment" do
        within("div.comment") do
          page.find('.like-this').click
        end
        expect(page).to have_css('.unlike-this')
      end

      context "where the comment is previously liked" do
        before do
          comment.likes << create(:comment_like, user_id: user.id)
          visit root_path
        end

        scenario "the user can unlike the comment" do
          within("div.comment") do
            page.find('.unlike-this').click
          end
          expect(page).to have_css('div.comment a.like-this')
        end
      end
    end
  end
end
