# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Profile.delete_all


Profile.create(user_id: 3, about_me: Faker::Hipster.sentence, words_to_live_by: Faker::Hipster.paragraph, hometown: Faker::Address.city, current_city: Faker::Address.city, telephone: Faker::PhoneNumber.cell_phone, college: Faker::University.name)