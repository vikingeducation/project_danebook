FactoryGirl.define do
  factory :photo do
    uploader
    uploaded_file { File.new(Rails.root.join('spec', 'asset_specs', 'images', 'test_photo.jpg'))}
  end

  factory :user, aliases: [:author, :uploader] do
    sequence(:email) {|n| "test#{n}@test.com" }
    password "foobar12"
    password_confirmation "foobar12"
    gender 0
    dob Time.now
    sequence(:first_name) {|n| "#{n}y"}
    sequence(:last_name) {|n| "#{n}son"}
  end

  factory :post do
    body "This is a test!"
    sequence(:created_at) {|n| DateTime.now + n.minutes }
    author
  end

  factory :comment do
    body "This is a comment!"
    created_at DateTime.now
    author

    commentable factory: :post

    factory :commented_comment do
      commentable factory: :comment
    end

    factory :commented_post do
      commentable factory: :post
    end

    factory :commented_photo do
      commentable photo: :photo
    end
  end

  factory :like do
    user
    factory :liked_post do
      likable factory: :post
    end

    factory :liked_comment do
      likable factory: :comment
    end

    factory :liked_photo do
      likable factory: :photo
    end
  end

  factory :friending do
    association :user
    association :friend
  end
end
