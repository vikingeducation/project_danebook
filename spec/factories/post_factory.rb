FactoryGirl.define do

  factory :post do
    content 'asdfa sadf asdf as dfa asdf as df sdfasd ffdsf'
    association :user
  end

end