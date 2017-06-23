# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Deleting users"
User.destroy_all


puts "Creating users"
3.times { |i| User.create(:email => "foo#{i}@onet.pl", :password => "lol#{i}", :password_confirmation => "lol#{i}") }
User.all.each { |u| puts "#{u}"}