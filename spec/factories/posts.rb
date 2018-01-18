FactoryBot.define do

  factory :post do
    sequence(:body){ |n| "this is the post body #{n}"}
    user
  end #post

end #FactoryBot
