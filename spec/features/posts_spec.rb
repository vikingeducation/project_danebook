require 'rails_helper'

describe "Timeline" do
  let(:profile){ create(:profile)}
  let(:second_profile){ create(:profile, first_name: "Ron", last_name: "Weasley")}
  let(:user){ profile.user }
  let(:second_user){ second_profile.user }

  feature "Create Post" do
    context "Authenticated" do
      before do
        sign_in(user)
      end
      context "Current User" do
        before do
          visit user_path(user)
        end
        it "displays a new post form on the timeline" do
          expect(page).to have_css("form#new_post textarea")
        end

        it "creates a new post" do
          within "form#new_post" do
            fill_in "post_body", with: "Test New Post"

            expect{click_button "Post"}.to change(Post, :count).by(1)
          end
        end

        it "redirects you to view the newly created post" do
          create_new_post
          expect(page).to have_current_path(user_post_path(user, Post.last))
        end
      end
      context "Other User" do
        before do
          visit user_path(second_user)
        end

        it "does not display the new post form" do
          expect(page).to_not have_css("form#new_post textarea")
        end

      end
    end
    context "Unauthenticated" do
      it "redirects to the login path" do
        visit user_path(user)
        expect(page).to have_current_path(login_path)
      end
    end
  end
end
