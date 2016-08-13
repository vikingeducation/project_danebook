# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Destroying users.."
Timeline.destroy_all
User.destroy_all
City.destroy_all
State.destroy_all
Country.destroy_all

puts "Building Cities.."
50.times do
  City.create!(name: Faker::Address.city)
end

puts "Building States.."
50.times do
  State.create!(name: Faker::Address.state)
end

puts "Building Countries.."
50.times do
  Country.create!(name: Faker::Address.country)
end

#Seed a user.
puts "Seeding a user.."
foobar = User.create!(email: 'foobar@barbaz.com',
                     #Use pw + pwc for seeds. Use pw_digest for fixtures.
                     password: 'foobar',
                     password_confirmation: 'foobar',
                     activated: true,
                     activated_at: rand(365).days.ago)
foobar.build_profile({ first_name: 'Foobar',
                       last_name: 'Barbaz' }).save

#Seed more users.
puts "Seeding more users.."
99.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "fake_email_#{n+1}@fmail.com"
  password_digest = User.digest('password')
  user = User.create!(email: email,
              password: 'foobar',
              password_confirmation: 'foobar',
              activated: true,
              activated_at: rand(365).days.ago)
  user.build_profile({ first_name: first_name, last_name: last_name }).save
end