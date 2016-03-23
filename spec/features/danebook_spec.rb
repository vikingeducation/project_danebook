require 'rails_helper'

feature 'Visit_Root_Page' do

  let(:user){ create(:user) }
  let(:profile){ create(:profile, user: user) }
  let(:posts){create_list(:post, 5, user: user)}

  context "visit root page as an unsigned user" do

    before do
      posts
      visit root_path
    end

    scenario "shows the sign up page" do
      expect(page).to have_content "Sign Up"
    end

    scenario "allows a valid sign up with all fields set" do
      
      fill_in('user[profile_attributes][first_name]', with: 'Bobby')
      fill_in('user[profile_attributes][last_name]', with: 'Martin')
      fill_in('Your User Name', with: 'bobby')
      fill_in('Your Email', with: 'bobby@gmail.com')
      fill_in('Your Password', with: '12345678')
      fill_in('Confirm Password', with: '12345678')
      fill_in('user[profile_attributes][birthdate]', with: '10-10-2015')
      
      choose('user_profile_attributes_gender_male')
      
      click_button "Sign Up!"

      #save_and_open_page
      expect(current_path).to eq(edit_user_path(2))
    end

    scenario "allows a valid sign-up without choosing a gender" do
      fill_in('user[profile_attributes][first_name]', with: 'Bobby')
      fill_in('user[profile_attributes][last_name]', with: 'Martin')
      fill_in('Your User Name', with: 'bobby')
      fill_in('Your Email', with: 'bobby@gmail.com')
      fill_in('Your Password', with: '12345678')
      fill_in('Confirm Password', with: '12345678')
      
      click_button "Sign Up!"
      
      expect(current_path).to eq(edit_user_path(2))
    end


    scenario "allows a valid sign-up without a birthdate" do
      fill_in('user[profile_attributes][first_name]', with: 'Bobby')
      fill_in('user[profile_attributes][last_name]', with: 'Martin')
      fill_in('Your User Name', with: 'bobby')
      fill_in('Your Email', with: 'bobby@gmail.com')
      fill_in('Your Password', with: '12345678')
      fill_in('Confirm Password', with: '12345678')
      
      choose('user_profile_attributes_gender_male')
      
      click_button "Sign Up!"
      
      expect(current_path).to eq(edit_user_path(2))
    end
  end

  context "edit information as signed user" do

    before do
      posts
      visit root_path
      sign_up_user_with_complete_default_attributes
    end

    scenario "allows edit with valid values" do
      fill_in('user[profile_attributes][college]', with: 'UCSC CA')
      fill_in('user[profile_attributes][hometown]', with: 'Mumbai,India')
      fill_in('user[profile_attributes][domicile]', with: 'San Jose,CA')
      fill_in('user[profile_attributes][my_words]', with: 'My words go here')
      fill_in('user[profile_attributes][about_me]', with: 'I am a vampire zombie with a hint of werewolf')
      
      click_button "Save your change"
      
      expect(current_path).to eq(user_path(2))
    end

    scenario "allows edit with no update" do
      click_button "Save your change"
      expect(page).to have_content('bobby@gmail.com was updated successfully!')
      expect(current_path).to eq(user_path(2))
    end
  end  

  context "show signed-in user information" do

    before do
      posts
      visit root_path
      sign_up_user_with_complete_default_attributes
    end

    scenario "with proper values in the show page" do
      fill_in('user[profile_attributes][college]', with: 'UCSC CA')
      fill_in('user[profile_attributes][hometown]', with: 'Mumbai,India')
      fill_in('user[profile_attributes][domicile]', with: 'San Jose,CA')
      fill_in('user[profile_attributes][my_words]', with: 'My words go here')
      fill_in('user[profile_attributes][about_me]', with: 'I am a vampire zombie with a hint of werewolf')

      click_button "Save your change"

      expect(page).to have_css("td#email", text: "bobby@gmail.com")
      #bcheck birthdate

      expect(page).to have_css("td#hometown", text: "Mumbai,India")
      expect(page).to have_css("td#college", text: "UCSC CA")
      expect(page).to have_css("td#domicile", text: "San Jose,CA")
      expect(page).to have_css("div.col-md-6", text: "My words go here")
      expect(page).to have_css("div.col-md-6", text: "I am a vampire zombie with a hint of werewolf")
      expect(current_path).to eq(user_path(2))
    end

  end

  context "show timeline page" do

    before do
      posts
      visit root_path
      sign_up_user_with_complete_default_attributes
    end

    scenario "when user clicks the Timeline link" do
      click_link "Timeline"
      expect(current_path).to eq(new_user_post_path(2))
    end

    scenario "with all posts for the user" do
      user_posts = create_list(:post, 5, user_id: 2)
      #### posts creation should be above Timeline ##"
      click_link "Timeline"
      expect(page).to have_css('.post-body', count: 5)
    end

    scenario "and allow to create a new post" do
      user_posts = create_list(:post, 5, user_id: 2)
      click_link "Timeline"
      fill_in('post[body]', with: 'Dummy Post')
      click_button "Post"
      expect(page).to have_css('.post-body', count: 6)
      expect(page).to have_css("div.post-body", text: 'Dummy Post')
    end

    scenario "and validate about link is usable" do
      user_posts = create_list(:post, 5, user_id: 2)
      click_link "Timeline"
      click_link "About"
      expect(current_path).to eq(user_path(2))
    end

    scenario "and validate edit profile link is usable" do
      user_posts = create_list(:post, 5, user_id: 2)
      click_link "Timeline"
      click_link "Edit Profile"
      expect(current_path).to eq(edit_user_path(2))
    end

    scenario "and allow to see posts for a different user" do
      user_posts = create_list(:post, 5, user_id: 1)
      user
      profile
      #byebug
      visit user_posts_path(1)
      expect(page).to have_css('.post-body', count: 10)
    end

    scenario "and validate you cannot create post on another user's timeline" do
      user_posts = create_list(:post, 5, user_id: 2)
      profile
      visit user_posts_path(1)
      expect(page).to_not have_css('.post-button')
      #BUG in the view here if NO USER POSTSs in 165
      #visit user_posts_path(2)
      #expect(page).to have_css('.post-button')
    end

  end

end