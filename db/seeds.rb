# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'destroying users'
User.destroy_all

puts 'creating users'
NUM_USERS = 10

NUM_USERS.times do |i|
  User.create(email: Faker::Internet.email, password: 'password' )
end
