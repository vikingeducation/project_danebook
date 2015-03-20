FactoryGirl.define do
  factory :comment do
    body "Betelgeuse Bellatrix Rigel Saiph Alnitak Alnilam Mintaka Meissa. Alkaid Mizar Alioth Megrez Dubhe Merak Phecda"
    association :user

    factory :post_comment do
      association :commentable, factory: :post
    end

    factory :photo_comment do
      association :commentable, factory: :photo
    end

  end
end