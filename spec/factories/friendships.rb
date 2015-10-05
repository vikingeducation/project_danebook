FactoryGirl.define do

  factory :friendship do

    initiator_id  1 #from alias defined in user factory
    acceptor_id   2 #from alias defined in user factory
    status "Pending"

  end

end
