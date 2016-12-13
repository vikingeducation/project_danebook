require 'rails_helper'

feature 'Danebook App' do

  let(:user) { create(:user) }

  context "when signed out" do

    scenario 'it redirects user to sign up page when trying to view any other page'

    scenario 'it signs up a user with appropriate credentials'

    scenario 'it does not sign up a user who is missing credentials'

    scenario 'it signs in a user who has just been created'

    scenario 'it allows a user to log in with appropriate credentials'

    scenario 'it does not allow a user to log in with missing credentials'

  end

  context "when signed in" do

    context "on user's own account" do

      scenario 'it redirects to about page when navigating to root'

      scenario 'it allows user to update information'

      scenario 'it allows user to post on his account'

      scenario 'it allows user to delete his posts'

    end

    context "on other users' pages"

      scenario 'it allows user to view other users\' about and timeline pages'

      scenario 'it does not allow user to view other users\' edit pages'

      scenario 'it does not allow user to post on other users\' timelines'

      scenario 'it allows user to comment on other users\' posts'

      scenario 'it does not allow user to delete other users\' posts'     

    end

  end

end