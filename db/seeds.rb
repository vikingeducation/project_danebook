# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

GENDERS = ["Female", "Male", "Rather Not Say"]

30.times do
  u = User.create(:first_name => Faker::Name.first_name,
              :last_name => Faker::Name.last_name,
              :email => Faker::Internet.email,
              :password => "verysecure",
              :password_confirmation => "verysecure" )

  u.build_profile(:gender => GENDERS.sample,
                  :day => (rand(28) + 1).to_s,
                  :month => (rand(12) + 1).to_s,
                  :year => (rand(100) + 1914).to_s,
                  :college => "#{Faker::Lorem.words(1).first.capitalize} College",
                  :hometown => Faker::Address.city,
                  :currently_lives => Faker::Address.city,
                  :telephone => Faker::PhoneNumber.phone_number,
                  :words_to_live_by => Faker::Company.bs.capitalize,
                  :about_me => Faker::Lorem.paragraph)
  u.save!

end

User.all.each do |user|

  5.times do
    user.posts.build(:body => Faker::Lorem.paragraph)
    user.save!
  end

end


#used several times from here on out to assign comments and likes
user_ids = User.pluck(:id)



Post.all.each do |post|
  num_comments = rand(5)
  num_likes = rand(11)

  num_comments.times do
    post.comments.build(:body => Faker::Hacker.say_something_smart,
                        :user_id => user_ids.sample)
  end

  #no reason all comments shouldn't save right
  post.save!

  num_likes.times do
    post.likes.build(:user_id => user_ids.sample)
  end

  post.save
  #some likes might be inadmissable repeats.
  #this is okay collateral damage

end

#assign likes to comments
Comment.all.each do |comment|
  num_likes = rand(11)

  num_likes.times do
    comment.likes.build(:user_id => user_ids.sample)
  end

  comment.save
end



