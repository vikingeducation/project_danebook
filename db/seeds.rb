# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Profile.delete_all
Post.delete_all
User.delete_all

puts "Creating users..."


def create_user
  new_user = User.create(
    first_name: Faker::Name.first_name, 
    last_name: Faker::Name.last_name, 
    email: Faker::Internet.email, 
    password_digest: "$2a$10$.MSTCUKj.7tpap8LswJXa.AeTlsa9Qmh0TWTcYJjqZd8bhMokgPbO", 
    birthday: Time.now, 
    gender: ["Male", "Female"].sample
  )
end

10.times do
  create_user
end

Profile.all.each do |p|
  p.about_me = Faker::Hipster.sentence
  p.words_to_live_by = Faker::Hipster.paragraph
  p.hometown = Faker::Address.city
  p.current_city = Faker::Address.city
  p.save
end


admin = User.create(
  first_name: Faker::Name.first_name, 
  last_name: Faker::Name.last_name, 
  email: "admin@admin.com", 
  password_digest: "$2a$10$.MSTCUKj.7tpap8LswJXa.AeTlsa9Qmh0TWTcYJjqZd8bhMokgPbO", 
  birthday: Time.now, 
  gender: "Female"
  )

admin_profile = Profile.find_by_user_id(admin.id)
admin_profile.about_me = Faker::Hipster.sentence
admin_profile.words_to_live_by = Faker::Hipster.paragraph
admin_profile.hometown = Faker::Address.city
admin_profile.current_city = Faker::Address.city
admin_profile.save


puts "Creating posts..."

def create_post
  Post.create(user_id: User.pluck(:id).sample, body: Faker::Hipster.sentence)
end


User.all.each do
  3.times { create_post }
end