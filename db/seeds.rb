# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

MULTIPLIER = 1

User.delete_all
Profile.delete_all
Post.delete_all
Comment.delete_all
Like.delete_all
Photo.all.each { |p| p.destroy } if Photo.all



# Create 10 Users with Profiles
(MULTIPLIER*10).times do
  u = User.new
  u.password = 'password'
  p = u.build_profile
  p.first_name = Faker::Name.first_name
  p.last_name = Faker::Name.last_name
  u.email = Faker::Internet.email("#{p.first_name}.#{p.last_name}")
  p.gender = ['Male', 'Female'].sample
  p.birthdate = Faker::Date.between(90.years.ago, 12.years.ago)
  p.college = Faker::Lorem.word.titleize
  p.hometown = Faker::Address.city
  p.currently_lives = Faker::Address.city
  p.telephone = Faker::PhoneNumber.phone_number
  p.words_to_live_by = Faker::Lorem.sentence
  p.description = Faker::Lorem.paragraph(1,true,3)
  u.save!
end


User.all.each do |u|
  # Create Posts for each User
  (MULTIPLIER*rand(0..2)).times do
    p = u.posts.build
    p.body = Faker::Lorem.paragraph(1,true,3)
    p.save!
  end

  # Create Photos for each User
  (MULTIPLIER*rand(0..2)).times do
    p = u.photos.build
    p.photo = open(Faker::Avatar.image)
    p.save!
  end

  # Create a bunch of friendships
  (MULTIPLIER*rand(0..5)).times do
    potential_friend = User.all.sample
    u.friended_users << potential_friend unless u.friended_users.include?(potential_friend)
  end
end


# For each Post & each Photo, pick 0-2 random Users to Comment on it
def write_comments(object)
  (MULTIPLIER*rand(0..2)).times do
    random_user = User.all.sample
    object.likers << random_user unless object.liker_ids.include?(random_user.id)
  end
end


# For each Post & each Comment, pick 0-4 random Users to Like it
def assign_likes(object)
  (MULTIPLIER*rand(0..4)).times do
    random_user = User.all.sample
    object.likers << random_user unless object.liker_ids.include?(random_user.id)
  end
end


Post.all.each do |p|
  write_comments(p)
  assign_likes(p)
end

Photo.all.each do |p|
  write_comments(p)
  assign_likes(p)
end

Comment.all.each do |c|
  assign_likes(c)
end