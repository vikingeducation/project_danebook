# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User.destroy_all

# 20.times do
#    User.create(:username => Faker::Internet.user_name,
#                :email => Faker::Internet.email,
#                :password_digest)
# end
# 
t_start = Time.now

puts "Starting now"

10.times do
  User.create(first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password")
end

puts "Created Users; #{Time.now - t_start} seconds"

User.all.each do |user|
  user.profile.birthday = Faker::Date.between(60.years.ago, 13.years.ago)
  user.profile.college = Faker::Company.name
  user.profile.hometown = Faker::Address.city
  user.profile.current_town = Faker::Address.city
  user.profile.telephone = Faker::PhoneNumber.phone_number
  user.profile.words_to_live_by = Faker::Lorem.sentence
  user.profile.about_me = Faker::Lorem.paragraph(10)
  user.profile.save

  users_arr = (1..User.count).to_a

  rand(0..9).times do
    friend = users_arr.delete(users_arr.sample)
    next if friend == user.id
    user.friended_users << User.find(friend)
  end
end

puts "Assigned Profiles to users; #{Time.now - t_start} seconds"

Profile.all.each do |profile|
  rand(2..10).times do
    post = profile.posts.create(:body => Faker::Lorem.paragraph(rand(1..20)))
    post.user_id = rand(1..User.count)
    post.save
  end
end

puts "Created Posts; #{Time.now - t_start} seconds"

Post.all.each do |post|
  rand(0..3).times do
    post.comments.create(:body => Faker::Lorem.paragraph(rand(1..3)))
  end
end

puts "Created Comments; #{Time.now - t_start} seconds"

likeables = ["Post", "Comment"]

200.times do
  like = Like.new(likeable_type: likeables.sample)
  if like.likeable_type == "Post"
    like.likeable_id = rand(1..Post.count)
  else
    like.likeable_id = rand(1.. Comment.count)
  end
  like.user_id = rand(1..User.count)
  like.save
end
puts "Created Likes; #{Time.now - t_start} seconds"





