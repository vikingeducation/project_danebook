# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all


10.times do
  u = User.create!(email: Faker::Internet.email, password: "password", password_confirmation: "password")
  u.create_profile(birthday: Faker::Date.between(100.years.ago, 10.years.ago), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, about: "People call me #{Faker::Superhero.name}")
  3.times do
    u.posts.create(body: Faker::Hipster.paragraph)
  end
end

10.times do
  u = User.all.sample
  post = Post.all.sample
  post.likes.create(user_id: u.id) if post.likes.where(user_id: u.id).empty?
  post.comments.create(user_id: u.id, body: Faker::Hipster.sentence)
end

10.times do
  u = User.all.sample
  comment = Comment.all.sample
  comment.likes.create(user_id: u.id) if comment.likes.where(user_id: u.id).empty?
  comment.comments.create(user_id: u.id, body: Faker::Hipster.sentence)
end
