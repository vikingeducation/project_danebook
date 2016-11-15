FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| FactoryHelper.email(n)}
    password 'password'
    sequence(:first_name) {|n| FactoryHelper.first_name(n)}
    sequence(:last_name) {|n| FactoryHelper.last_name(n)}
    birthday do 
      Date.new(rand(1900..2015), rand(1..12), rand(1..28))
    end
    gender
  end
end