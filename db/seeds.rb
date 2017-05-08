# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "clearing db..."
Like.destroy_all
Comment.destroy_all
Post.destroy_all
Photo.destroy_all
Profile.destroy_all
Friending.destroy_all
User.destroy_all
puts "DONE"

puts "creating users..."
20.times do |i|
  User.create(
    email: "foo#{i}@bar.com",
    password: "foobar",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birth_month: rand(1..12),
    birth_date: rand(1..28),
    birth_year: rand(1980..2000)
    )
end
puts "DONE"

puts "creating posts..."
User.all.each do |user|
  user.posts.create(
    content: Faker::Lorem.paragraph,
    created_at: Faker::Date.between(2.years.ago, Time.now)
    )
end
puts "DONE"

puts "creating comments..."
Post.all.each do |post|
  post.comments.create(
    user_id: User.pluck(:id).sample,
    content: Faker::Lorem.paragraph
    )
end
puts "DONE"


puts "SEEDING COMPLETE"