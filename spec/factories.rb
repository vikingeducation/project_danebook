FactoryGirl.define do

  factory :friendship do
    user_id 1
    friend_id 2
    status "accepted"
  end

  factory :user do
    first_name  "Foo"
    last_name   "Bar"
    sequence(:email){ |n| "test#{n}@test.com"}
    # sequence(:email) do |n| "foo#{n}@gmail.com" end
    gender      "male"
    birthday    Time.now
    password "password"
  end

  factory :profile do
    user_id 1
    college "foo"
    telephone "8888888"
    hometown "barville"
    current_location "bar"
    about_me "foo"
    words_to_live_by "bar"

  end

  factory :post do
    user_id 1
    body    "ifsifhsjkfhfwehioquwehfweufhweouifqweioufhuih"
  end

  factory :comment do
    user_id 1
    body    "ifsifhsjkfhfwehioquwehfweufhweouifqweioufhuih"
    commentable_type "Post"
    commentable_id 1
  end

  factory :like do
    user_id 1
    likeable_id 2
    likeable_type "Post"
  end

  factory :photo do
    user_id 1
    data_file_name "foo"
    data_content_type "image/png"
    data_file_size 5
  end
end