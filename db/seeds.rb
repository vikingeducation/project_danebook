# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Profile.destroy_all

75.times do 
  password = Faker::Internet.password
  user = User.new(:first_name => Faker::Name.first_name, 
                  :last_name => Faker::Name.last_name,
                  :email => Faker::Internet.email,  
                  :password => password, 
                  :password_confirmation => password)

  user.build_profile(
                     :user_id => user.id,
                     :birthday => Faker::Date.between(14.years.ago, 80.years.ago),
                     :college => Faker::Lorem.word,
                     :photo_url => Faker::Avatar.image, 
                     :current_town => Faker::Address.city, 
                     :hometown => Faker::Address.city, 
                     :telephone => Faker::PhoneNumber.cell_phone,
                     :words_to_live_by => Faker::Company.catch_phrase,
                     :about_me => Faker::Lorem.paragraph(8, true)
                     )

  user.save
end

  