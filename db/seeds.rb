# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def maybe(x)
  [x, nil].sample
end

# reset db
User.delete_all
Post.delete_all
Comment.delete_all
Like.delete_all
FriendRequest.delete_all
Status.delete_all
Photo.delete_all

# create users
5.times do
  fname, lname = Faker::Name.first_name, Faker::Name.last_name
  usr = User.create(
    email: Faker::Internet.email(fname + "_" + lname),
    password_digest: BCrypt::Password.create("foobar123")
  )
  # create the profile
  Profile.create!(
    user_id: usr.id,
    first_name: fname,
    last_name: lname,
    birthday: maybe(Time.now),
    gender: ["Male", "Female"].sample,
    college: maybe(Faker::Educator.university),
    hometown: maybe([Faker::Address.city, Faker::Address.state_abbr].join(", ")),
    currently_lives: maybe([Faker::Address.city, Faker::Address.state_abbr].join(", ")),
    telephone: maybe(Faker::PhoneNumber.cell_phone),
    words: maybe(Faker::Hacker.say_something_smart),
    about: maybe(Faker::Lorem.paragraph),
    profile_photo_id: nil,
    cover_photo_id: nil
  )
end
# create posts
10.times do
  Post.create(
    user_id: User.pluck(:id).sample,
    body: Faker::Lorem.paragraph
  )
end

# create comments
20.times do
  commentable = [Post].sample.all.sample
  commentable.comments.create(
    user_id: User.pluck(:id).sample,
    body: Faker::Lorem.paragraph
  )
end

# create likes
40.times do
  likable = [Post, Comment].sample.all.sample
  likable.likes.create(
    user_id: User.pluck(:id).sample
  )
end

# create status
Status.create(message: "Pending")
Status.create(message: "Accepted")
Status.create(message: "Declined")
Status.create(message: "Blocked")


# create friendships
20.times do
  users = User.all
  user1, user2 = users.sample, users.sample
  status = Status.find_by(message: ["Accepted", "Pending"].sample)
  begin
    raise if user1 == user2
    FriendRequest.create(
      user_one_id: user1.id,
      user_two_id: user2.id, status_id:
      status.id
    )
  rescue
  end
end

# create photos
20.times do
  user_id = User.pluck(:id).sample
  Photo.create(
    user_id: user_id,
    asset: File.new("#{Rails.root}/spec/support/fixtures/image.png"))
end

# set profile photos
User.all.each do |user|
  unless user.photos.blank?
    user.profile.profile_photo = user.photos.first
    user.save
  end
end
