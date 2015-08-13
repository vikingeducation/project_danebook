# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Post.all.destroy_all
User.all.destroy_all
Comment.destroy_all
Profile.destroy_all
Like.destroy_all
UserPosting.destroy_all


20.times do 
  name = Faker::Name.name.split(" ")

  User.create(email: Faker::Internet.email, password: "12345678", gender: rand(1), dob: Faker::Date.backward(30), first_name: name[0], last_name: name[1])

end

User.all.each do |user|
  user.profile = Profile.new(college_name: "ucsb", hometown: Faker::Address.city, current_home: Faker::Address.city, telephone: Faker::PhoneNumber.phone_number, words_to_live_by: Faker::Lorem.sentence(3), about_me: Faker::Lorem.sentence(3))

  rand(1..3).times do
    user.posts<<Post.new(body: Faker::Lorem.sentence)
  end
end

Post.all.each do |post|
  post.comments.build(user_id: User.all.sample, body: Faker::Lorem.word)
  post.likes.build(user_id: User.all.sample)
end
