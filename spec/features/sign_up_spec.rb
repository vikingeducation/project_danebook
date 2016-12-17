require 'rails_helper'

feature "Signing up" do

  context "sign up" do

    it "allows a new user to sign up"

    it "disallows a new user from using an existing email"

    it "disallows a logged-in user from creating an additional account"

    it "redirects to the about edit page upon signup"

    it "integrates gender, birthday, name, and email into the new user's profile"

  end

  context "quit" do

    it "allows a user to delete his account, redirecting to the sign up page"

    it "doesn't log in a deleted user to their deleted account"

    it "disallows a user from deleting someone else's account"

  end

end