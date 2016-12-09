# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
NUM_USERS = 20
NUM_POSTS = 50

puts "Destroying everything"
Rake::Task["db:reset"]


puts "Creating New Users"
NUM_USERS.times do 
  User.create!( first_name: Faker::Name.first_name, 
                last_name: Faker::Name.last_name, 
                password: "password123", 
                email: Faker::Internet.free_email
                )
end

puts "Creating Profiles for Users"
User.all.each do |user|
  Profile.create!( user_id: user.id, 
                   birthday: Faker::Date.between(40.years.ago, 10.years.ago), 
                   gender: ["male", "female"].sample, 
                   college: Faker::Pokemon.location,
                   hometown: Faker::GameOfThrones.city,
                   residence: Faker::Address.city,
                   telephone: Faker::PhoneNumber.phone_number,
                   summary: Faker::Hipster.paragraph(3, true, 4),
                   about_me: Faker::Hipster.paragraphs(5, true)
                   )

end

puts "Creating posts for users"
NUM_POSTS.times do 
  Post.create!( user_id: Faker::Number.between(User.first.id, User.last.id),
                body: Faker::Hipster.paragraph(3, true, 4)
              )

end
puts "Done"