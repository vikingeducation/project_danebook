# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# ----------------------------------------
# Database Reset
# ----------------------------------------

if Rails.env == 'development'
  puts 'Reseting database'

  Rake::Task['db:migrate:reset'].invoke
end

# ----------------------------------------
# Seed Config Vars
# ----------------------------------------

MULTIPLIER = 10

# ----------------------------------------
# Users & Profiles
# ----------------------------------------

def generate_user_and_profile
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  u = User.new
  u.first_name  = first_name
  u.last_name   = last_name
  u.email       = Faker::Internet.free_email("#{first_name} #{last_name}")
  u.password = "qwerqwer"
  u.save


  up = Profile.new
  up.user_id = u.id
  up.gender = rand(0..1) == 1 ? "Male" : "Female"
  up.birthday = Faker::Date.between(50.years.ago, Date.today)
  up.college = Faker::Company.name
  up.from = "#{Faker::Address.city}, #{Faker::Address.state}"
  up.lives = "#{Faker::Address.city}, #{Faker::Address.state}"
  up.number = Faker::PhoneNumber.phone_number
  up.words = Faker::Hipster.paragraph
  up.about = Faker::Hipster.paragraph
  up.save
end

# ----------------------------------------
# Posts
# ----------------------------------------

def generate_post
  post = Post.new
  post.body = Faker::Hipster.paragraph
  post.user_id = User.pluck(:id).sample
  post.created_at = Faker::Date.between(50.years.ago, Date.today - 30)
  post.save
end

# ----------------------------------------
# Comments to post
# ----------------------------------------

def generate_comments_to_post
  comment = Comment.new
  comment.body = Faker::Hipster.paragraph
  comment.user_id = User.pluck(:id).sample
  post_id = Post.pluck(:id).sample
  comment.commentable_id = post_id
  comment.commentable_type = "Post"
  comment.created_at = Post.find(post_id).created_at + rand(1..30)
  comment.save
end

puts "Creating Users and Profiles"
(MULTIPLIER * 2).times { |id| generate_user_and_profile }
puts "Creating Posts"
(MULTIPLIER * 10).times { generate_post }
puts "Creating Comments"
(MULTIPLIER * 20).times { generate_comments_to_post }
puts "Done!"
