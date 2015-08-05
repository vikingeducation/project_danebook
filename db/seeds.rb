# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Profile.destroy_all
Post.destroy_all
Like.destroy_all
Comment.destroy_all

MULTIPLIER = 10

#create users
MULTIPLIER.times do
  User.create( first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              :password => "password",
              :password_confirmation => "password",
              birthdate: Faker::Time.between(100.years.ago, 13.years.ago))
end

users = User.all
#create profiles

users.each do |user|
  user.profile.update( college: "#{Faker::Company.name} college",
                        hometown: Faker::Address.city,
                        location: Faker::Address.city,
                        motto: Faker::Lorem.sentence,
                        about: Faker::Lorem.paragraph)
end

#create posts
(MULTIPLIER*3).times do
  users.sample.posts.create(body: Faker::Lorem.paragraph)
end

posts = Post.all

#create comments

(MULTIPLIER*3).times do
  posts.sample.comments.create(user_id: users.sample.id,
                              body: Faker::Lorem.paragraph)
end

comments = Comment.all
#create likes
(MULTIPLIER*5).times do
  liker_id = users.sample.id
  posts.sample.likes.create( user_id: liker_id)
  comments.sample.likes.create(user_id: liker_id)
end
