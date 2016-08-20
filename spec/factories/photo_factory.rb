FactoryGirl.define do
  factory :photo do
    avatar_file_name
    avatar_content_type
    profile
    cover
    user
  end
end