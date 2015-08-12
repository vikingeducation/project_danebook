FactoryGirl.define do  factory :friending do
    
  end

  factory :user do
    first_name {"foo"}
    last_name {"bar"}
    sequence(:email){|n|"foo#{n}@bar.com"}
    password {"foobar"}
    password_confirmation {"foobar"}
  end


  factory :profile do
    college {"Foo State"}
    hometown {"Foo City"}
    current_town {"Foo Town"}
    telephone {"555.555.5555"}
    words_to_live_by {"Lorem ipsum dolor sit amet, consectetur adipisicing elit. Vel debitis, ut. Amet quae, commodi modi neque beatae asperiores dolores autem praesentium libero obcaecati a voluptate eos ab consequuntur dignissimos quam!"}
    about_me {"Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptatem in quasi dolor odio vel ex voluptas dolorem at, nobis cumque est suscipit consectetur perferendis, adipisci architecto non fugiat exercitationem voluptate."}
    user   
  end

  factory :post do
    profile
    user
    body {"Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellendus dolores, consequuntur voluptatem? Natus doloremque impedit alias mollitia, atque nostrum, veniam possimus iure consectetur, unde iusto, cumque dolores nemo quibusdam officia?"}
  end

  factory :comment do
    post
    user
    body {"Lorem ipsum dolor sit amet, consectetur adipisicing elit. Odit odio accusamus magnam excepturi nostrum doloremque sed praesentium, ullam, numquam adipisci ipsa inventore! Quibusdam aliquid placeat beatae porro voluptatum quod, eaque!"}
  end

  factory :comment_like, class: "Like" do
    association :likeable, factory: :comment
    user
  end

  factory :post_like, class: "Like" do
    association :likeable, factory: :post
    user
  end

  factory :friender, class: "User" do
    association :friended_users, factory: :user
  end

  factory :friendee, class: "User" do
    association :users_friended_by, factory: :user
  end



end