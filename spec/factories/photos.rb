FactoryGirl.define do
  factory :photo do
      picture_file_name "test_photo.jpg"
      picture_content_type "image/jpeg"
      picture_file_size 83261
      association :profile 
  end
end