require 'rails_helper'
include ActionDispatch::TestProcess

RSpec.describe PhotosHelper, type: :helper do
  context "methods" do

    let(:uploader) { create(:user) }
    let(:viewer) { create(:user) }
    let(:photo) { create(:photo, user: uploader) }

    describe "#image_or_linked_image" do

      before do
        assign(:viewer, viewer)
        def helper.current_user
          @viewer
        end
      end

      it "shows a regular image if viewer and uploader aren't friends" do
        expect(helper.image_or_linked_image(photo, uploader)).
        to eq("<img src=\"https://s3.amazonaws.com/davidmeza/animation_processing.gif\" alt=\"Animation processing\" />")
      end

      it "shows a linked image if viewer and uploader are friends" do
        create(:friending, friender: viewer, target: uploader)
        expect(helper.image_or_linked_image(photo, uploader)).
        to eq("<a href=\"/photos/#{photo.id}\"><img src=\"https://s3.amazonaws.com/davidmeza/animation_processing.gif\" alt=\"Animation processing\" /></a>")
      end
    end
  end
end
