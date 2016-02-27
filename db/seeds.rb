# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Profile.destroy_all
Comment.destroy_all
Post.destroy_all
Like.destroy_all
MULT=30

MULT.times do |i|
  User.create!(:email => Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password_digest: "password", password_confirmation: "password", birthday: Time.now, gender: ["Male","Female"].sample)
end

Photo.create(user_id: 1, 
              photo: File.new("#{Rails.root}/public/avatar.jpg"))
Photo.create(user_id: 1, 
              photo: File.new("#{Rails.root}/public/cover.jpg"))
binding.pry

User.all.each do |user|

  user.profile.update(user_id: user.id, 
                college: Faker::Name.title, 
                phone: Faker::PhoneNumber.cell_phone, 
                hometown: Faker::Address.city, 
                homecountry: "USA", 
                livesintown: Faker::Address.city, 
                livesincountry: "USA", 
                wordsby: Faker::Lorem.sentence, 
                wordsabout: Faker::Lorem.sentence,
                avatar_id: Photo.first.id, cover_id: Photo.last.id)

  rand(1..MULT/4).times do
    Post.create!(user_id: user.id, body: Faker::Name.title+"Post from user #{user.full_name}")
  end

  rand(1..MULT/10).times do
    Friending.create(user_id: user.id, friend_id: User.all.sample.id)
  end

  rand(1..MULT/10).times do
    Comment.create!(user_id: user.id, body: Faker::Name.title+" from user #{user.full_name}", commenting_id: rand(1..MULT), commenting_type: ["Post","Comment"].sample)
  end

  rand(1..MULT/6).times do
    Like.create!(user_id: user.id, liking_id: rand(1..MULT), liking_type: ["Post","Comment"].sample)
  end

end

