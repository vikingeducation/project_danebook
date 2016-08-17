require 'rails_helper'

feature 'Sessions' do
  let(:user){ build(:user) }
  before do
    visit root_path
  end

  feature 'Authentication' do
    before do
      user.save!
    end
    context "with improper credentials" do
      before do
        user.email = user.email + "x"
        sign_in(user)
      end

      scenario "does not allow sign in" do
        expect(page).to have_selector ".alert-error"
      end
    end

    context "with proper credentials" do
      let(:profile) { create(:profile) }
      before do
        user.profile = profile
        sign_in(user)
      end
      scenario "successfully signs in an existing user" do
        expect(page).to have_selector ".alert-success"
      end

      context "after signing out" do
        before do
          sign_out
        end
        scenario "signs out the user" do
          expect(page).to have_selector ".alert-success"
        end
      end
    end
  end


  feature 'Sign Up' do
    let(:profile) { create(:profile) }

    context "with valid user information" do
      before do
        user.profile = profile
      end

      scenario "successfully creates a new user" do
        expect { sign_up(user) }.to change(User, :count).by(1)
        expect(page).to have_selector ".alert-success"
      end
    end

    context "with invalid user information" do
      let(:invalid_user) { build(:user, password: "") }
      before do
        invalid_user.profile = profile
      end
      scenario "does not create a new user with blank password" do
        sign_up(invalid_user)
        expect(page).to have_selector ".alert-error"
      end
    end

  end
end
