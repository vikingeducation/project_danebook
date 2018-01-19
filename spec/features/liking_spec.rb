require 'rails_helper'

feature 'Liking', type: :feature do
  let(:user){ create(:user) }
  before do
    visit root_path
  end

  context "A visitor" do

    xscenario 'can not make a new like' do
      visit new_user_post_path(user)
      expect(current_path).to eq(login_path)
    end
  end #visitors

  context 'As a signed-in user' do
    before do
      login(user)
    end

    context 'on their Timeline' do
      before do
        visit user_timeline_path(user)
      end

      scenario "can like a post" do
        write_post
        click_link('Like')
        expect(page).to have_content('Unlike')
      end

      scenario "can unlike a post" do
        write_post
        click_link('Like')
        click_link('Unlike')
        expect(page).to have_content('Like')
      end

      scenario "can like a comment" do
        write_post
        write_comment
        within('div.comment') do
          click_link('Like')
        end
        expect(page).to have_content('Unlike')
      end

      scenario "can unlike a comment" do
        write_post
        write_comment
        within('div.comment') do
          click_link('Like')
        end
        click_link('Unlike')
        expect(page).to have_content('Like')
      end

    end #Timeline

    context 'on their Feed' do
      before do
        visit user_feed_path(user)
      end

      scenario "can like a post" do
        write_post
        click_link('Like')
        expect(page).to have_content('Unlike')
      end

      scenario "can unlike a post" do
        write_post
        click_link('Like')
        click_link('Unlike')
        expect(page).to have_content('Like')
      end

      scenario "can like a comment" do
        write_post
        write_comment
        within('div.comment') do
          click_link('Like')
        end
        expect(page).to have_content('Unlike')
      end

      scenario "can unlike a comment" do
        write_post
        write_comment
        within('div.comment') do
          click_link('Like')
        end
        click_link('Unlike')
        expect(page).to have_content('Like')
      end
    end #Feed


  end #signed-in user

end #Liking
