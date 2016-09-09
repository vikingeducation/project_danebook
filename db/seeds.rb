# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "seeding.. destroying assets..."
User.destroy_all
Post.destroy_all
Like.destroy_all
Friending.destroy_all
Comment.destroy_all
puts "creating users..."
5.times do |i|
  User.create(email: "foo#{i}@bar.com",
              password: "foobar", password_confirmation: "foobar",
              first_name: "foo#{i}", last_name: "bar#{i}",
              gender: "male", b_month: 5, b_day: 3, b_year: 1985)
end

puts "creating posts.."
User.all.each do |user|
  Post.create(body: "I'm #{user.first_name}. Lorem Ipsem blah blee blue",
                author_id: user.id)
end

puts "creating comments"

Post.all.each do |post|
  user = User.all.sample
  Comment.create(commentable_id: post.id, commentable_type: "Post",
                  commenter_id: user.id, body: "I'm #{user.first_name}. You're #{post.author.first_name}.")
end

puts "creating likes"
  Post.all.each do |post|
    num = rand(3)+1
    num.times do
      Like.create(likable_id: post.id, liker_id: User.all.sample.id,
                  likable_type: "Post")
    end
  end

  Comment.all.each do |comment|
    num = rand(3)+1
    num.times do
      Like.create(likable_id: comment.id, liker_id: User.all.sample.id,
                  likable_type: "Comment")
    end
  end

puts "creating friends"
User.all.each do |user|
  friends = []
  until friends.length == 2
    friend = User.all.sample
    friend == user ? nil : friends << friend
    friends.uniq!
  end
  friends.each do |friend|
    Friending.create(friend_id: friend.id, friender_id: user.id)
  end
end

puts "done seeding"
