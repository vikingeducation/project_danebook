# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(first_name: 'Foobar',
             last_name: 'Barbaz',
             email: 'foobar@barbaz.com',
             password: 'foobar',
             password_confirmation: 'foobar',
             activated: true,
             activated_at: rand(365).days.ago)

99.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "fake_email_#{n+1}@fmail.com"
  password = 'password'
  User.create!(first_name: first_name,
              last_name: last_name,
              email: email,
              password: password,
              password_confirmation: password,
              activated: true,
              activated_at: rand(365).days.ago)
end