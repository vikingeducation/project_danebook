# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
srand(12345)
User.destroy_all
Post.destroy_all
Comment.destroy_all

10.times do
  User.create(email: Faker::Internet.email,
              password: "dddddddd",
              password_confirmation: "dddddddd",
              gender: rand(0..1),
              dob: Faker::Date.between(40.years.ago, Date.today),
              first_name: Faker::Name.name.split[-2],
              last_name: Faker::Name.name.split[-1])
end

User.all.each do |user|
  user.profile.update(college: Faker::Team.name + " college",
                 hometown: Faker::Address.street_address + ", " + Faker::Address.state,
                 location: Faker::Address.street_address + ", " + Faker::Address.state,
                 words: Faker::Lorem.paragraph,
                 about: Faker::Lorem.paragraph,
                 telephone: Faker::PhoneNumber.phone_number)

end

User.all.each do |user|
  rand(0..2).times do
    user.written_posts.create!(body: Faker::Lorem.paragraph)
  end
end

User.all.each do |user|
  rand(1..4).times do
    user.comments.create(body: Faker::Lorem.paragraph, commentable: Post.all.sample)
  end
end

User.all.each do |user|
  rand(2..4).times do
    rand_user = User.all.sample
    user.friends << rand_user unless user.friends.include?(rand_user) || rand_user == user
  end
end

User.all.each do |user|
  rand(4..6).times do
    rand_post = Post.all.sample
    user.liked_posts << rand_post unless user.liked_posts.include? rand_post
  end
end


User.all.each do |user|
  rand(4..6).times do
    rand_comment = Comment.all.sample
    user.liked_comments << rand_comment unless user.liked_comments.include? rand_comment
  end
end
