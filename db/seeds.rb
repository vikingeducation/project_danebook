# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Destroying users.."
User.destroy_all

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
  user.build_profile({ first_name: first_name,
                       last_name: last_name }).save
end

#Seeding microposts.
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end