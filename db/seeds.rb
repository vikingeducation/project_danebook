# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Killing users off ...... ..... ... .. ."
User.destroy_all

puts "Now their profiles .......... . . . . ."
Profile.destroy_all

puts "Now the likes .......... . . . . ."
Like.destroy_all

puts "Now dem comments .......... . . . . ."
Comment.destroy_all

puts "Building users ...... ..... ... .. ."
1.upto(6) do |i|
  u = User.create!(:email => "chuck#{i}@norris.com", :password => "chuckskick", :first_name => Faker::Name.first_name, :last_name => "Norris", birth_date: Faker::Date.between(2000.days.ago, Date.today))

  u.profile.update(college: Faker::University.name, hometown: Faker::Address.city, currently_lives: Faker::Address.city, telephone: Faker::PhoneNumber.cell_phone, words_to_live_by: Faker::Hipster.paragraph(2), about_me: Faker::Hipster.paragraph(4))
end
