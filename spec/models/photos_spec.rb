require 'rails_helper'

describe Photo do
  let(:photo) { create(:photo) }

  describe "data" do

    it "should have a data attribute" do

      expect(photo).to respond_to(:data)

    end

  end

  describe "filename" do

    it "should have a filename attribute" do

      expect(photo.filename).to be_a(String)

    end

  end

  describe "mime_type" do

    it "should have a mime_type attribute" do

      expect(photo.mime_type).to be_a(String)

    end

  end

  describe "#photo_data=" do

    it "should set the data attribute of the row"

    it "should set the filename attribute of the row"

    it "should set the mime_type attribute of the row"

  end

  describe "associations" do

    it "belongs to a user"

    it "has many comments"

    it "has many likes"

  end


end