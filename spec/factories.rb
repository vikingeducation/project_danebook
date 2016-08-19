FactoryGirl.define do
  factory :photo do
    user_id nil
  end
  factory :friendship do
    
  end

  factory :user do
    first_name "Test"
    sequence(:last_name) do |n|
      "Ting#{n}"
    end
    sequence(:email) do |n|
      "test#{n}@viking.com"
    end
    password "password"
    password_confirmation "password"
    birth_date Time.now
    gender "female"
  end

  factory :post do
    text "If good things come to those who wait, why is procrastinating bad?"

    association :author, factory: :user
  end

  factory :comment do
    text "LOL!!!1!"

    association :commenter, factory: :user

    factory :post_comment do
      association :commentable, factory: :post
    end

    factory :comment_comment do
      association :commentable, factory: :comment
    end
  end

  factory :like do
    user

    factory :post_like do
      association :likable, factory: :post
    end

    factory :comment_like do
      association :likable, factory: :comment
    end
  end

  factory :city do
    name "Springfield"
    country "Russia"
  end

end
