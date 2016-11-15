FactoryGirl.define do
  factory :gender do
  end

  factory :male, :class => :gender do
    name 'Male'
    short_name 'm'
  end

  factory :female, :class => :gender do
    name 'Female'
    short_name 'f'
  end
end