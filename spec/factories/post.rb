FactoryGirl.define do
  factory :post do
    body "Hroðulf and Hroðgar held the longest peace together, uncle and nephew, since they repulsed the Viking-kin hewn at Heorot Heaðobard's army, and Ingeld to the spear-point made bow"
    association :user
  end
end