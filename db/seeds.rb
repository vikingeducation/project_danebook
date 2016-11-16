# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Deleting data"
User.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all
Photo.destroy_all
Profile.destroy_all
Friending.destroy_all

MULTIPLIER = 10

puts "Creating users"
MULTIPLIER.times do
  User.create(:email => Faker::Internet.email,
              :password => Faker::Internet.password)
end

GENDERS =["male", "female"]
POSTS =[1,2,3,4,5]
puts "Creating profiles and posts"
User.all.each do |u|
  Profile.create(:first_name => Faker::Name.first_name,
                 :last_name => Faker::Name.last_name,
                 :gender => GENDERS.sample,
                 :college => Faker::University.name,
                 :hometown => Faker::Address.city,
                 :currently_lives => Faker::Address.city,
                :telephone => Faker::PhoneNumber.cell_phone,
                :words_to_live_by => Faker::Lorem.sentence,
                :about_me => "Hi, thanks for visting my page. I currently work at #{Faker::Company.name} and my favorite color is #{Faker::Color.color_name}.",
                :user_id => u.id,
                :birthday => "2000-08-11")

  POSTS.sample.times do 
    u.posts.create(:body => Faker::Lorem.sentence)
  end
end

puts "Creating comments"
(MULTIPLIER*2).times do
  user = User.all.sample
  post = Post.all.sample
  user.comments.create(:body=> Faker::Lorem.sentence,
                       :commentable_id=> post.id,
                      :commentable_type => "Post")
end

puts "Creating likes"
User.all.each do |user|
  post = Post.all.sample
  user.likes.create( :likeable_id=> post.id,
                      :likeable_type => "Post")
end

puts "Done!"

