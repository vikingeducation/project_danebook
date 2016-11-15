include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :photo do
    user

    factory :profile_photo do
      file {fixture_file_upload(FactoryHelper.profile_photo, 'image/png')}
    end

    factory :cover_photo do
      file {fixture_file_upload(FactoryHelper.cover_photo, 'image/jpeg')}
    end

    factory :other_photo do
      file {fixture_file_upload(FactoryHelper.other_photo, 'image/jpeg')}
    end
  end
end

