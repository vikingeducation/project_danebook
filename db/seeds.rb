# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Users

User.new({
  first_name: "Jane",
  last_name:  "Smith",
  email:      "jane.smith@example.com",
  password:   "password",
  gender:     "Female",
  birthday:   Date.today - 21.years
}).save

User.first.build_profile.save

32.times do
  u = User.new

  u.first_name = Faker::Name.first_name
  u.last_name  = Faker::Name.last_name
  u.email      = Faker::Internet.free_email(u.name)
  u.password   = Faker::Internet.password(8)
  u.gender     = ["Female", "Male", "Other"].sample
  u.birthday   = Faker::Date.between(73.years.ago, 13.years.ago)
  u.created_at = Faker::Time.between(6.months.ago, Time.now)

  u.save

  # Add some photos
  (rand(10)+1).times do
    photo = u.photos.build
    photo.photo_from_url(Faker::Avatar.image)
    photo.save
  end

  # Profile
  u.build_profile({
    school:         Faker::Company.name,
    hometown:       Faker::Address.city,
    current_town:   Faker::Address.city,
    phone_number:   Faker::PhoneNumber.phone_number,
    quotes:         Faker::Lorem.sentence,
    about:          Faker::Lorem.paragraph,
    created_at:     Time.now - 3.months,
    photo_id:       u.photos.shuffle.first.id,
    cover_photo_id: u.photos.shuffle.first.id
  }).save

  # Add some posts
  (rand(20)).times do
    u.posts.build({
      content:    Faker::Hacker.say_something_smart,
      created_at: Faker::Time.between(u.created_at, Time.now)
    }).save
  end
end

# Friends
User.all.each do |user|
  User.all.shuffle[0..rand(32)].each do |friend|
    if friend != user
      Friending.new({
        friender_id: user.id,
        friend_id:   friend.id
      }).save
    end
  end

  # Bots accept all friend requests
  if user.id != 1
    user.friend_requests.each do |friend|
      Friending.new({
        friender_id: user.id,
        friend_id:   friend.id
      }).save
    end
  end
end

# Comments
User.all.each do |user|
  if user.id != 1
    Post.where(author_id: user.friends.pluck(:id)).shuffle[0..rand(50)].each do |post|
      post.comments.build({
        author_id:  user.id,
        content:    Faker::Lorem.sentence,
        created_at: Faker::Time.between(post.created_at, Time.now)
      }).save
      post.likes.build(liker_id: user.id).save
    end
  end
end


