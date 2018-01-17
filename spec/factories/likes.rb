FactoryBot.define do

  factory :like_on_post, class: Like do
    user
    association :likeable, factory: :post
  end

  factory :like_on_post_comment, class: Like do
    user
    association :likeable, factory: :comment_on_post
  end

  # commenting on comments has not been implemented yet
  factory :like_on_comment_comment, class: Like do
    user
    association :likeable, factory: :comment_on_comment
  end


end #FactoryBot
