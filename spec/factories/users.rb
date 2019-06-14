FactoryBot.define do

  factory :user do
    sequence(:name){ |n| "Foo#{n}"}
    email { "#{name}@example.com" }
    password 'password'
  end

end #FactoryBot
