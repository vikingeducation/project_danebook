FactoryGirl.define do
  factory :photo do
    avatar_file_name "panda.jpg"
    avatar_content_type "image/jpeg"
    profile false
    cover false
    user
  end
end