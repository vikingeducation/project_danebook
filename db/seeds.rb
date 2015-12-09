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

GENDERS = [
  {:name => 'Male', :short_name => 'm'},
  {:name => 'Female', :short_name => 'f'}
]

IMAGES_PATH = "#{Rails.root}/public/assets/images/"
PROFILE_PHOTO_PATHS = Dir["#{IMAGES_PATH}profile-photos/*"] - ["#{IMAGES_PATH}profile-photos/default.png"]
COVER_PHOTO_PATHS = Dir["#{IMAGES_PATH}cover-photos/*"] - ["#{IMAGES_PATH}cover-photos/default.png"]
OTHER_PHOTO_PATHS = Dir["#{IMAGES_PATH}other-photos/*"]

# --------------------------------------------
# Skip Callbacks
# --------------------------------------------

Comment.skip_callback(:create, :after, :feedable_created)
Comment.skip_callback(:create, :after, :queue_notification_email)
FriendRequest.skip_callback(:create, :after, :queue_notification_email)
Friendship.skip_callback(:create, :after, :queue_notification_email)
Friendship.skip_callback(:create, :after, :feedable_created)
Photo.skip_callback(:create, :after, :feedable_created)
Post.skip_callback(:create, :after, :feedable_created)
Profile.skip_callback(:update, :after, :feedable_updated)
Like.skip_callback(:create, :after, :queue_notification_email)
Like.skip_callback(:create, :after, :feedable_created)
User.skip_callback(:create, :before, :create_profile)
User.skip_callback(:create, :after, :queue_welcome_email)

# --------------------------------------------
# Helper Methods
# --------------------------------------------

def random_birthday
  rand(1..100).years.ago
end

def random_date
  rand(0..5000).days.ago
end

def days_between_now_and(date)
  (Date.today - date.to_date).to_i
end

def random_photo_file_path(type=:other)
  {
    :profile => PROFILE_PHOTO_PATHS.sample,
    :cover => COVER_PHOTO_PATHS.sample,
    :other => OTHER_PHOTO_PATHS.sample
  }[type]
end

# --------------------------------------------
# Create Genders
# --------------------------------------------

puts 'Creating Genders'
Gender.create(GENDERS)
gender_ids = Gender.pluck(:id)

# --------------------------------------------
# Create Users
# --------------------------------------------

puts 'Creating Users'
users = []
FIRST_NAMES.each_with_index do |first_name, i|
  LAST_NAMES.each_with_index do |last_name, j|
    date = random_date
    users << {
      :email => "#{first_name.downcase}@#{last_name.downcase}.com",
      :password => PASSWORD,
      :first_name => first_name,
      :last_name => last_name,
      :birthday => random_birthday,
      :gender_id => gender_ids.sample,
      :created_at => date,
      :updated_at => date
    }
  end
end
User.create(users)
user_ids = User.pluck(:id)

# --------------------------------------------
# Initialize Activity Accumulator
# --------------------------------------------

activities = []

# --------------------------------------------
# Create Profiles
# --------------------------------------------

puts 'Creating Profiles'
profiles = []
user_ids.each do |user_id|
  date = random_date
  profiles << {
    :user_id => user_id,
    :college => COLLEGES.sample,
    :hometown => HOMETOWNS.sample,
    :currently_lives => HOMETOWNS.sample,
    :telephone => TELEPHONES.sample,
    :words_to_live_by => TEXT_BODIES.sample,
    :about_me => TEXT_BODIES.sample,
    :created_at => date,
    :updated_at => date
  }

  activities << {
    :user_id => user_id,
    :feedable_id => profiles.length,
    :feedable_type => 'Profile',
    :verb => :update,
    :created_at => date,
    :updated_at => date
  }
end
Profile.create(profiles)
profile_ids = Profile.pluck(:id)

# --------------------------------------------
# Create FriendRequests
# --------------------------------------------

puts 'Creating FriendRequests'
friend_requests = []
user_ids.each do |initiator_id|
  user_ids[0..rand(user_ids.length - 1)].each do |approver_id|
    date = random_date
    friend_requests << {
      :initiator_id => initiator_id,
      :approver_id => approver_id,
      :created_at => date,
      :updated_at => date
    } unless initiator_id == approver_id
  end
end
FriendRequest.create(friend_requests)
friend_request_ids = FriendRequest.pluck(:id)

# --------------------------------------------
# Create Friendships
# --------------------------------------------

puts 'Creating Friendships'
friendships = []
FriendRequest.all.each do |friend_request|
  if friend_request.id.even?
    friend_request.approved = true
    friend_request.save

    date = friend_request.created_at

    friendships << {
      :initiator_id => friend_request.initiator_id,
      :approver_id => friend_request.approver_id,
      :created_at => date,
      :updated_at => date
    }

    activities << {
      :user_id => friend_request.initiator_id,
      :feedable_id => friendships.length,
      :feedable_type => 'Friendship',
      :verb => :create,
      :created_at => date,
      :updated_at => date
    }

    activities << {
      :user_id => friend_request.approver_id,
      :feedable_id => friendships.length,
      :feedable_type => 'Friendship',
      :verb => :create,
      :created_at => date,
      :updated_at => date
    }
  end
end
Friendship.create(friendships)
friendship_ids = Friendship.pluck(:id)

# --------------------------------------------
# Create Photos
# --------------------------------------------

puts 'Creating Photos'
photos = []
user_ids.each do |user_id|
  rand(0..(10 * MULTIPLIER)).times do
    date = random_date
    photo_file = File.new(random_photo_file_path)
    other_photo = Photo.create(
      :file => photo_file,
      :user_id => user_id,
      :created_at => date,
      :updated_at => date
    )
    photo_file.close

    activities << {
      :user_id => user_id,
      :feedable_id => other_photo.id,
      :feedable_type => 'Photo',
      :verb => :create,
      :created_at => date,
      :updated_at => date
    }
  end

  date = random_date
  user = User.find(user_id)
  photo_file = File.new(random_photo_file_path(:profile))
  profile_photo = Photo.create(
    :file => photo_file,
    :user_id => user_id,
    :created_at => date,
    :updated_at => date
  )
  user.profile_photo_id = profile_photo.id
  photo_file.close

  activities << {
    :user_id => user_id,
    :feedable_id => profile_photo.id,
    :feedable_type => 'Photo',
    :verb => :create,
    :created_at => date,
    :updated_at => date
  }

  date = random_date
  photo_file = File.new(random_photo_file_path(:cover))
  cover_photo = Photo.create(
    :file => photo_file,
    :user_id => user_id,
    :created_at => date,
    :updated_at => date
  )
  user.cover_photo_id = cover_photo.id
  photo_file.close

  activities << {
    :user_id => user_id,
    :feedable_id => cover_photo.id,
    :feedable_type => 'Photo',
    :verb => :create,
    :created_at => date,
    :updated_at => date
  }

  user.save
end
photo_ids = Photo.pluck(:id)

# --------------------------------------------
# Create Posts
# --------------------------------------------

puts 'Creating Posts'
posts = []
user_ids.each do |user_id|
  rand(0..(5 * MULTIPLIER)).times do
    date = random_date
    posts << {
      :user_id => user_id,
      :body => TEXT_BODIES.shuffle.first,
      :created_at => date,
      :updated_at => date
    }

    activities << {
      :user_id => user_id,
      :feedable_id => posts.length,
      :feedable_type => 'Post',
      :verb => :create,
      :created_at => date,
      :updated_at => date
    }
  end
end
Post.create(posts)
post_ids = Post.pluck(:id)

# --------------------------------------------
# Create Comments
# --------------------------------------------

puts 'Creating Comments'
comments = []
user_ids.each do |user_id|
  rand(0..(5 * MULTIPLIER)).times do
    date = random_date
    comments << {
      :user_id => user_id,
      :commentable_id => post_ids.shuffle.first,
      :commentable_type => 'Post',
      :body => TEXT_BODIES.shuffle.first,
      :created_at => date,
      :updated_at => date
    }

    activities << {
      :user_id => user_id,
      :feedable_id => comments.length,
      :feedable_type => 'Comment',
      :verb => :create,
      :created_at => date,
      :updated_at => date
    }
  end

  rand(0..(5 * MULTIPLIER)).times do
    date = random_date
    comments << {
      :user_id => user_id,
      :commentable_id => photo_ids.shuffle.first,
      :commentable_type => 'Photo',
      :body => TEXT_BODIES.shuffle.first,
      :created_at => date,
      :updated_at => date
    }

    activities << {
      :user_id => user_id,
      :feedable_id => comments.length,
      :feedable_type => 'Comment',
      :verb => :create,
      :created_at => date,
      :updated_at => date
    }
  end
end
Comment.create(comments)
comment_ids = Comment.pluck(:id)

# --------------------------------------------
# Create Likes
# --------------------------------------------

puts 'Creating Likes'
likes = []
Post.all.each do |post|
  post_id = post.id
  rand(0..(5 * MULTIPLIER)).times do
    date = random_date
    likes << {
      :likeable_id => post_id,
      :likeable_type => 'Post',
      :user_id => user_ids.shuffle.first,
      :created_at => date,
      :updated_at => date
    }

    activities << {
      :user_id => post.user_id,
      :feedable_id => likes.length,
      :feedable_type => 'Like',
      :verb => :create,
      :created_at => date,
      :updated_at => date
    }
  end
end

Comment.all.each do |comment|
  comment_id = comment.id
  rand(0..(5 * MULTIPLIER)).times do
    date = random_date
    likes << {
      :likeable_id => comment_id,
      :likeable_type => 'Comment',
      :user_id => user_ids.shuffle.first,
      :created_at => date,
      :updated_at => date
    }

    activities << {
      :user_id => comment.user_id,
      :feedable_id => likes.length,
      :feedable_type => 'Like',
      :verb => :create,
      :created_at => date,
      :updated_at => date
    }
  end
end

Photo.all.each do |photo|
  photo_id = photo.id
  rand(0..(5 * MULTIPLIER)).times do
    date = random_date
    likes << {
      :likeable_id => photo_id,
      :likeable_type => 'Photo',
      :user_id => user_ids.shuffle.first,
      :created_at => date,
      :updated_at => date
    }

    activities << {
      :user_id => photo.user_id,
      :feedable_id => likes.length,
      :feedable_type => 'Like',
      :verb => :create,
      :created_at => date,
      :updated_at => date
    }
  end
end
Like.create(likes)
like_ids = Like.pluck(:id)

# --------------------------------------------
# Create Activities
# --------------------------------------------

puts 'Creating Activities'
Activity.create(activities)
activity_ids = Activity.pluck(:id)

puts 'done!'









