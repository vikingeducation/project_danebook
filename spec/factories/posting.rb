FactoryGirl.define do
  factory :posting do
    user

    factory :text_posts do
      association :postable, factory: :post
    end

    factory :photo_posts do
      association :postable, factory: :photo
    end
  end
end
