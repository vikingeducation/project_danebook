# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
NUM_USERS = 20
NUM_POSTS = 50
NUM_COMMENTS = 75
NUM_POST_LIKES = 100
NUM_COMMENT_LIKES = 100

puts "Destroying everything"
User.destroy_all
Profile.destroy_all
Like.destroy_all
Comment.destroy_all
Post.destroy_all


puts "Creating New Users"
NUM_USERS.times do 
  User.create!( first_name: Faker::Name.first_name, 
                last_name: Faker::Name.last_name, 
                password: "password123", 
                email: Faker::Internet.free_email
                )
end

puts "Creating your account. Email: test@email.com, Password: password"
User.create!( first_name: Faker::Name.first_name, 
                last_name: Faker::Name.last_name, 
                password: "password", 
                email: "test@email.com"
                )

puts "Creating Profiles for Users"
User.all.each do |user|
  Profile.create!( user_id: user.id, 
                   birthday: Faker::Date.between(40.years.ago, 10.years.ago), 
                   gender: ["male", "female"].sample, 
                   college: Faker::Pokemon.location,
                   hometown: Faker::GameOfThrones.city,
                   residence: Faker::Address.city,
                   telephone: Faker::PhoneNumber.phone_number,
                   summary: Faker::Hipster.paragraph(3, true, 4),
                   about_me: Faker::Hipster.paragraphs(5, true)
                   )

end

puts "Creating posts for users"
NUM_POSTS.times do 
  Post.create!( user_id: Faker::Number.between(User.first.id, User.last.id),
                body: Faker::Hipster.paragraph(3, true, 4)
              )

end

puts "Creating comments for posts"
NUM_COMMENTS.times do 
  Comment.create!( user_id: Faker::Number.between(User.first.id, User.last.id),
                commentable_id: Faker::Number.between(Post.first.id, Post.last.id),
                commentable_type: "Post",
                body: Faker::Hipster.paragraph(3, true, 4)
              )

end

puts "Creating likes for posts"
NUM_POST_LIKES.times do 
  user_id = Faker::Number.between(User.first.id, User.last.id) 
  likeable_id =  Faker::Number.between(Comment.first.id, Comment.last.id)
  if Like.where(user_id: user_id, likeable_id: likeable_id, likeable_type: "Post").empty?
     Like.create( user_id: user_id,
                likeable_id: likeable_id,
                likeable_type: "Post"
                )
  end
end

puts "Creating likes for comments"
NUM_COMMENT_LIKES.times do 
  user_id = Faker::Number.between(User.first.id, User.last.id) 
  likeable_id =  Faker::Number.between(Comment.first.id, Comment.last.id)
  if Like.where(user_id: user_id, likeable_id: likeable_id, likeable_type: "Comment").empty?
                Like.create(user_id: user_id,
                            likeable_id: likeable_id,
                            likeable_type: "Comment"
                            )
  end 
end

puts "Done"
puts "Your account: Email: test@email.com, Password: password"