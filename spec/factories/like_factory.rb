FactoryGirl.define do

  factory :like do
    user
    
    factory :post_like do
      association :likable, :factory => :post
    end

    factory :comment_like do
      association :likable, :factory => :comment
    end
  end

end