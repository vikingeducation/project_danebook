# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "Destroying Users"
if Rails.env == 'development'
  User.destroy_all
end

puts "Creating Users"
User.create!(email: 'harry_potter@hogwarts.edu', password: 'password',
  first_name: 'Harry', last_name: 'Potter', birthday: Date.new(1980, 7, 31))
