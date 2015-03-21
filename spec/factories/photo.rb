FactoryGirl.define do
  factory :photo do
    association :user

    image_file_name "cashcatz.jpg"
    image_content_type "image/jpeg"
    image_file_size 1.megabytes
    image_updated_at Time.now
  end
end