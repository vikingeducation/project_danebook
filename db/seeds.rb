# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroying existing objects"
User.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all

puts "Creating users"
10.times do |i|
  name = Faker::HarryPotter.unique.character.split
  puts "#{name}"
  firstname = name[0]
  
  if name.length == 1
    lastname = "Smith"
  else
    lastname = name[1]
  end
  email = "foo#{i}@foo.com"
  birthday = DateTime.new(1985+i,1+i,5+i)
  telephone = Faker::PhoneNumber.phone_number
  words_to_live_by = Faker::Lorem.paragraph
  hometown = Faker::HarryPotter.location.truncate(30)
  currently_lives = Faker::HarryPotter.location.truncate(30)
  about_me = Faker::HarryPotter.quote
  password_digest = BCrypt::Password.create("foobar#{i}")

  u = User.create!(
                  :email => email,
                  :password_digest => password_digest)
   Profile.create!(:user_id => u.id,
                  :firstname => firstname,
                  :lastname => lastname,
                  :birthday => birthday,
                  :gender => ["Male", "Female"].sample,
                  :telephone => telephone,
                  :college => "Hogwarts",
                  :hometown => hometown,
                  :currently_lives => currently_lives,
                  :words_to_live_by => words_to_live_by,
                  :about_me => about_me 
                  ) 
  u.save!
end
puts "Created users complete"

puts "Creating posts"
50.times do |i|
  Post.create!(:body => "#{i+1} #{Faker::Lorem.paragraph}", :user_id => User.all.sample.id)
end
puts "Created posts complete"

puts "Creating comments"
20.times do |i|
  commentable_type = "Post"
  commentable_id = commentable_type.constantize.all.sample.id
  Comment.create!(:body => "#{i+1} #{Faker::Lorem.sentence}", 
                  :user_id => User.all.sample.id, 
                  :commentable_id => commentable_id,
                  :commentable_type => commentable_type)
end
puts "Created comments complete"

puts "Creating likes"
20.times do |i|
  likeable_type = ["Comment","Post"].sample
  likeable_id = likeable_type.constantize.all.sample.id
  Like.create!(   :user_id => User.all.sample.id, 
                  :likeable_id => likeable_id,
                  :likeable_type => likeable_type)
end
puts "Created likes complete"


puts "Creating likes"
5.times do |i|
  friend_id = User.all.sample.id
  sample_user = User.all.sample.id 
  if user != friend_id
    friender_id = sample_user
  else
    friender_id - 1
  end

  end
  Friending.create!(:friend_id => friend_id, 
                  :friender_id => friender_id)
end
puts "Created likes complete"


