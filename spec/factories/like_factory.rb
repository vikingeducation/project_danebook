FactoryGirl.define do

  factory :post_like, class: 'Like' do
    association :liked, factory: :post
    user
  end

  factory :comment_like, class: 'Like' do
    association :liked, factory: :comment
    user
  end

end