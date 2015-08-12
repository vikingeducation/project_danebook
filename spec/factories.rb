# spec/factories.rb
FactoryGirl.define do

  # A block defining the attributes of a model
  # The symbol is how you will later call it
  # Factory Girl assumes that your class name
  # is the same as the symbol you passed
  # (so here, it assumes this is a User)
  factory :user do
    sequence(:email) { |n| "foo#{n}@bar.com" }
    password "foobar"
  end

  factory :post do
    sequence(:body) { |n| "post #{n}" }
    user
  end

  factory :post_comment do
    sequence(:body) { |n| "post comment #{n}"}
    user
    association :commentable, :factory => :post
  end

  factory :photo do
    sequence(:user_photo_file_name) { |n| "Photo#{n}"}
    user_photo_content_type "image/jpeg"
    user_photo_file_size 1000
    user_photo_updated_at DateTime.now
    user
  end

  factory :photo_comment do
    sequence(:body) { |n| "photo comment #{n}"}
    user
    association :commentable, :factory => :photo
  end

  factory :post_like, class: "Like" do
    association :likable, :factory => :post
    user
  end

  factory :comment_like, class: "Like" do
    association :likable, :factory => :comment
    user
  end

  factory :profile do
    sequence(:first_name) { |n| "foo#{n}" }
    sequence(:last_name) { |n| "bar#{n}" }
    sequence(:college) { |n| "college #{n}" }
    sequence(:hometown) { |n| "town #{n}" }
    sequence(:current_lives) { |n| "city #{n}" }
    gender ["male", "female"].shuffle[0]
    user
  end

  factory :friending do
    association :friend_initiator, :factory => :user
    association :friend_recipient, :factory => :user
  end

end



