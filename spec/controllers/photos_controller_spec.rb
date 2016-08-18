require 'rails_helper'

RSpec.describe PhotosController, type: :controller do

  describe "#new" do

    context "when the user is logged in and the correct user" do

      it "assigns the new photo variable"

    end

    context "when the user is not logged in" do

      it "redirects to the login page"

    end

    context "when the user is not the correct user" do

      it "redirects to the root path"

    end

  end

  describe "#create" do

    context "when the user is logged in and the correct user" do

      it "persists the photo to the database"

      it "redirects the user to his timeline"

    end

    context "when the user is not logged in" do

      it "redirects the user to the login page"

    end

    context "when the user is not the correct user" do

      it "redirects the user to the root path"

    end

  end

end
