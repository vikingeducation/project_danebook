# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroying existing records..."
User.destroy_all

puts "Populating users..."
('a' .. 'z').each do |a|
  u = User.new(email: "#{a}@#{a}.com", password: a * 12, password_confirmation: a * 12)
  u.build_profile(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, sex: ['female', 'male'].sample, birthdate: Faker::Date.between(80.years.ago, 13.years.ago), college: Faker::University.name, hometown: Faker::Address.city, current_city: Faker::Address.city, telephone: Faker::PhoneNumber.phone_number, quote: Faker::Hacker.say_something_smart, about: Faker::Hipster.sentence(3))
  u.save
end

puts 'Populating posts...'
User.all.each do |u|
  rand(1..5).times do
    u.posts.create(body: Faker::Hipster.sentence(5))
  end
end

puts 'Populating likes...'
Post.all.each do |po|
  rand(1..5).times do
    po.likes.create(user_id: User.all.pluck(:id).sample)
  end
end
puts "Done!"
