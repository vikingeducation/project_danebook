# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# disable mailing
ActionMailer::Base.perform_deliveries = false

puts "Destroying existing records..."
User.destroy_all


puts "Populating users..."
('a' .. 'g').each do |a|
  u = User.new(email: "#{a}@#{a}.com", password: a * 12, password_confirmation: a * 12, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, )
  u.build_profile(sex: ['female', 'male'].sample, birthdate:Faker::Date.birthday(13, 99), college: Faker::University.name, hometown: Faker::Address.city, current_city: Faker::Address.city, telephone: Faker::PhoneNumber.phone_number, quote: Faker::Hacker.say_something_smart, about: Faker::Hipster.sentence(3))
  u.save!
end

puts 'Populating posts...'
User.all.each do |u|
  rand(1..5).times do
    u.posts.create(body: Faker::Hacker.say_something_smart, created_at: Faker::Date.between(5.months.ago, Date.today))
  end
end

puts 'Populating comments and likes...'
Post.all.each do |po|
  rand(1..5).times do
    po.likes.create(user_id: User.all.pluck(:id).sample, likeable_type: 'Post')
    po.comments.create(user_id: User.all.pluck(:id).sample, body: Faker::Hacker.say_something_smart, created_at: Faker::Date.between(5.months.ago, Date.today))
  end
end

puts 'Populating comment likes...'
Comment.all.each do |co|
  rand(0..5).times do
    co.likes.create(user_id: User.all.pluck(:id).sample, created_at: Faker::Date.between(5.months.ago, Date.today) )
  end
end

puts 'Populating friends...'

User.all.each do |u|
  ids = User.all.pluck(:id)
  rand(1..5).times do
    u.initiated_friendships.create(friendee_id: ids.sample)
  end
end

Friendship.all.each do |f|
  f.update(rejected: false)
end


puts "Done!"
