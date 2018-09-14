# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# delete all exsiting data
if User.destroy_all
  puts "Users deleted"
end

if Post.destroy_all
  puts "Posts deleted"
end

if Comment.destroy_all
  puts "Comments deleted"
end


MULTIPLIER = 20

MULTIPLIER.times do |x|
  email = Faker::Internet.email
  password = "password"
  if User.create(email: email, password: password, password_confirmation: password)
    puts "User Created!"
  end
end

User.all.each do |u|
  f_name = Faker::Name.first_name
  l_name = Faker::Name.last_name
  bday = Faker::Date.birthday(18,65)
  college = Faker::University.name
  hometown = Faker::Address.city
  current_town = Faker::Address.city
  telephone = Faker::PhoneNumber.phone_number
  words = Faker::RickAndMorty.quote
  about = Faker::RickAndMorty.quote
  gender = ["male", "female"].sample
  u.build_profile(first_name: f_name,
                   last_name: l_name,
                    birthday: bday,
                     college: college,
                    hometown: hometown,
                current_town: current_town,
                   telephone: telephone,
            words_to_live_by: words,
                    about_me: about
                )
  if u.save
    puts "user profile created"
  end
end


User.all.each do |u|
  rand(1..20).times do |x|
    body = Faker::Simpsons.quote
    u.posts.build(body: body)
    if u.save
      puts "post created"
    end
  end
end


Post.all.each do |post|
  user_id = User.all.sample.id
  body = Faker::RickAndMorty.quote
  post.comments.build(user_id: user_id, body: body, commentable_id: post.id, commentable_type: 'Post')
  if post.save
    puts "comment created"
  end
end


100.times do |x|
  user_id = User.all.sample.id
  likable_id = Post.all.sample.id
  likable_type = "Post"
  Like.create(user_id: user_id, likable_id: likable_id, likable_type: likable_type)
end

100.times do |x|
  user_id = User.all.sample.id
  likable_id = Comment.all.sample.id
  likable_type = "Comment"
  Like.create(user_id: user_id, likable_id: likable_id, likable_type: likable_type)
end
