require 'rails_helper'

describe Photo do
  AWS.stub!
  it 'should have an associated uploader' do
    expect(create(:photo).uploader).to eq(User.last)
  end

  AWS.stub!
  it 'should be in the uploaded photos of a user after creation' do
    new_user = create(:user)
    new_photo = create(:photo, uploader: new_user)
    new_user.reload
    expect(new_user.uploaded_photos).to match_array(new_photo)
  end
end
