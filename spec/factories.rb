FactoryGirl.define do  factory :friending do
    
  end


  factory :user, :aliases => [:author, :commenter, :liker] do
    sequence(:last_name) {|n| "Bar#{n}"}
    sequence(:first_name) {|n| "Foo#{n}"}
    gender "Male"
    sequence(:b_month) {|n| 1+n}
    sequence(:b_day) {|n| n+1}
    sequence(:b_year) {|n| n+1}
    email  {"#{first_name}@bar.com"}
    password "foobar"
    password_confirmation "foobar"

    trait :frequent_author do
      after_build do |user|
        create_list( :post, 5, author: user )
      end
    end

  end

  factory :post, :aliases => [:commentable] do
    sequence(:body) {|n| "#{n} Ipsem Lorem"}
    association :author, :factory => :user
  end

  factory :comment do
    sequence(:body) {|n| "#{n} Dubium Lorensioremal"}
    association :commenter, :factory => :user
    commentable_type "Post"
    association :commentable, :factory => :post
  end

  factory :like do
    likable_type "Post"
    association :likable, :factory => :post
    association :liker, :factory => :user


  end
end
