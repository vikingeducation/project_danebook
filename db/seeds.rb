# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.delete_all
Profile.delete_all
Post.delete_all
Comment.delete_all
Like.delete_all



# Create 50 Users with Profiles
50.times do
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
  # Create 2-6 Posts for each User
  rand(2..6).times do
    p = u.posts.build
    p.body = Faker::Lorem.paragraph(1,true,3)
    p.save!
  end

  # Create 3-10 Comments for each User on random other user posts
  rand(3..10).times do
    p = Post.all.sample
    c = p.comments.build
    c.author_id = u.id
    c.body = Faker::Lorem.paragraph(1,true,1)
    p.save!
  end

  # Create a bunch of friendships
  rand(8..30).times do
    potential_friend = User.all.sample
    u.friended_users << potential_friend unless u.friended_users.include?(potential_friend)
  end
end


# For each Post & each Comment, pick 0-7 random Users to Like it
def assign_likes(object)
  rand(0..7).times do
    random_user = User.all.sample
    object.likers << random_user unless object.liker_ids.include?(random_user.id)
  end
end


Post.all.each do |p|
  assign_likes(p)
end

Comment.all.each do |c|
  assign_likes(c)
end
