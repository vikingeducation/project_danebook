FactoryBot.define do

  factory :like_on_post, class: Like do
    user
    association :likeable, factory: :post
  end

  factory :like_on_comment, class: Like do
    user
    association :likeable, factory: :comment
  end


end #FactoryBot
