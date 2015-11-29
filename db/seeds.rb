# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# --------------------------------------------
# Destroy Old Data
# --------------------------------------------

unless Rails.env == 'production'
  puts 'Destroying old data'
  Rake::Task['db:migrate:reset'].invoke
end

# --------------------------------------------
# Multiplier
# --------------------------------------------

MULTIPLIER = 1

# --------------------------------------------
# Global Variables
# --------------------------------------------

TEXT_BODIES = [
  'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aperiam cupiditate quibusdam nulla nobis, recusandae velit, commodi non amet delectus saepe doloribus cum ratione est excepturi porro a consectetur aliquam iste!',
  'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nam in quas facilis possimus deleniti blanditiis mollitia et quam nisi, maiores labore est. Nemo ducimus non, velit explicabo libero maiores facilis!',
  'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloribus omnis maxime ducimus officiis magni quas dolore odio minus harum iusto, cumque dolorum mollitia sequi, facere voluptatem temporibus laboriosam placeat non?',
  'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reprehenderit laboriosam, atque. Esse non fuga laudantium iure quo sint inventore mollitia provident nisi beatae quod atque, voluptatum, hic maxime maiores sunt.',
  'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusantium provident repudiandae qui harum, corporis repellendus illo impedit voluptatum rem nulla quae est aspernatur minus quam nesciunt doloremque fuga sequi culpa.',
  'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eveniet accusamus, veritatis fuga id nam corrupti quis quos inventore, perspiciatis ab! Fugiat animi, qui doloribus aut quas enim dignissimos libero dolorum?'
]

# --------------------------------------------
# Create Genders
# --------------------------------------------

puts 'Creating genders'
GENDERS = [
  {:name => 'Male', :short_name => 'm'},
  {:name => 'Female', :short_name => 'f'}
]
Gender.create(GENDERS)

# --------------------------------------------
# Create Users and Profiles
# --------------------------------------------

puts 'Creating users and profiles'
FIRST_NAMES = [
  'Moe',
  'Larry',
  'Curly',
  'Elmer',
  'Mickey',
  'Daffy',
  'Bugs',
  'Porky',
  'Minnie',
  'Tom',
  'Jerry'
]
LAST_NAMES = [
  'Fud',
  'Mouse',
  'Duck',
  'Bunny',
  'Pig',
  'Cat'
]
PASSWORD = 'password'
birthday_year_range = 18..50
gender_id_range = 1..Gender.count

COLLEGES = [
  'School Academy',
  'College University',
  'We Don\'t Need No Education'
]

HOMETOWNS = [
  'Townville, USA',
  'Winchestertonfieldville, England',
  'The Abyss, Vortex',
  'Outerspace, Neptune'
]

TELEPHONES = [
  '1-123-123-1234',
  '1 (123) 123-1234',
  '234 234 1234',
  '+1 (123) 123-1234',
  '867-5309'
]

users = []
FIRST_NAMES.each_with_index do |first_name, i|
  LAST_NAMES.each_with_index do |last_name, j|
    users << {
      :email => "#{first_name.downcase}@#{last_name.downcase}.com",
      :password => PASSWORD,
      :first_name => first_name,
      :last_name => last_name,
      :birthday => rand(birthday_year_range).years.ago,
      :gender_id => rand(gender_id_range),
      :profile_attributes => {
        :college => COLLEGES.sample,
        :hometown => HOMETOWNS.sample,
        :currently_lives => HOMETOWNS.sample,
        :telephone => TELEPHONES.sample,
        :words_to_live_by => TEXT_BODIES.sample,
        :about_me => TEXT_BODIES.sample
      }
    }
  end
end
User.create(users)
user_ids = User.pluck(:id)

# --------------------------------------------
# Create FriendRequests
# --------------------------------------------

puts 'Creating FriendRequests'
user_ids.each do |user_id|

end

# --------------------------------------------
# Create Friendships
# --------------------------------------------

puts 'Creating Friendships'
user_ids.each do |user_id|
  
end

# --------------------------------------------
# Create Posts
# --------------------------------------------

puts 'Creating Posts'
posts = []
user_ids.each do |user_id|
  rand(0..(5 * MULTIPLIER)).times do
    date = rand(0..1000).days.ago
    posts << {
      :user_id => user_id,
      :body => TEXT_BODIES.shuffle.first,
      :created_at => date,
      :updated_at => date
    }
  end
end
Post.create(posts)

# --------------------------------------------
# Create Comments
# --------------------------------------------

puts 'Creating Comments'
post_ids = Post.pluck(:id)
comments = []
user_ids.each do |user_id|
  rand(0..(5 * MULTIPLIER)).times do
    date = rand(0..1000).days.ago
    comments << {
      :user_id => user_id,
      :commentable_id => post_ids.shuffle.first,
      :commentable_type => 'Post',
      :body => TEXT_BODIES.shuffle.first,
      :created_at => date,
      :updated_at => date
    }
  end
end
Comment.create(comments)

# --------------------------------------------
# Create Likes
# --------------------------------------------

puts 'Creating Likes'
likes = []
post_ids.each do |post_id|
  rand(0..(5 * MULTIPLIER)).times do
    likes << {
      :likeable_id => post_id,
      :likeable_type => 'Post',
      :user_id => user_ids.shuffle.first
    }
  end
end
comment_ids = Comment.pluck(:id)
comment_ids.each do |comment_id|
  rand(0..(5 * MULTIPLIER)).times do
    likes << {
      :likeable_id => comment_id,
      :likeable_type => 'Comment',
      :user_id => user_ids.shuffle.first
    }
  end
end
Like.create(likes)

puts 'done!'










