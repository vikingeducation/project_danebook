FactoryGirl.define do
  factory :profile do
    sequence(:college){|n| FactoryHelper.college(n)}
    sequence(:hometown){|n| FactoryHelper.hometown(n)}
    sequence(:currently_lives){|n| FactoryHelper.hometown(n + rand(0..10))}
    sequence(:telephone){|n| FactoryHelper.telephone(n)}
    sequence(:words_to_live_by){|n| FactoryHelper.text(n)}
    sequence(:about_me){|n| FactoryHelper.text(n)}
    user
  end
end