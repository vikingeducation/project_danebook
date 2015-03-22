# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all

50.times do
  User.create(
    :email => Faker::Internet.email,
    :password_digest => Faker::Lorem.word
    )
end

User.all.each do |user|
  Profile.create(
    :currenttown => Faker::Address.city,
    :hometown => Faker::Address.city,
    :email => user.email,
    :user_id => user.id,
    :aboutme => Faker::Lorem.sentence,
    :words => Faker::Lorem.sentence,
    :telephone => Faker::Lorem.word
    )
end