puts 'Deleting existing...'

resources = [Like, Comment, Post, User]
resources.each do |resource|
  puts "#{resource.count} #{resource}s"
  resource.destroy_all
end

puts '','Building new...'
puts 'Users w/o profiles'
User.create!(name: 'anne', email: 'anne@email.com', password: 'password')
3.times do
  user_name = Faker::Hobbit.unique.character
  user = User.create!({
    name: user_name,
    email: Faker::Internet.email(user_name),
    password: 'password'
  })
  puts "Building user posts"
  3.times do
    user.posts.create!(body: "#{Faker::Hobbit.quote} #{Faker::Lorem.paragraph}")
  end
end


puts 'Users with profiles'
5.times do
  user_name = Faker::HarryPotter.unique.character
  user = User.create!({
    name: user_name,
    email: Faker::Internet.email(user_name),
    birthday: Faker::Date.birthday(15, 25),
    hometown: Faker::HarryPotter.location,
    current_town: Faker::HarryPotter.location,
    college: Faker::University.name,
    phone: Faker::PhoneNumber.phone_number,
    quote: Faker::HarryPotter.quote,
    bio: Faker::Lorem.paragraph,
    headshot_pic: 'https://placeimg.com/150/150/people',
    cover_pic: 'https://placeimg.com/770/230/nature',
    password: 'password'
  })
  puts "Building user posts"
  3.times do
    user.posts.create!(body: "#{Faker::HarryPotter.quote} #{Faker::Lorem.paragraph}")
  end
end

puts "User count: #{User.count}"

puts "Adding comments and likes to posts"
post_count = Post.all.count
posts = Post.all.sample(post_count)
posts.each do |post|
  (1..4).to_a.sample.times do
    post.comments.create!(body: "#{Faker::Lorem.paragraph}", user_id: User.all.sample.id)
    post.likes.create!(user_id: User.all.sample.id)
  end
end

puts "Adding likes to comments"
comment_count = Comment.all.count
comments = Comment.all.sample(comment_count)
comments.each do |comment|
  (1..4).to_a.sample.times do
    # comment.comments.create!(body: "#{Faker::Lorem.paragraph}.", user_id: User.all.sample.id)
    comment.likes.create!(user_id: User.all.sample.id)
  end
end

# User.all.each do |user|
#   3.times do
#     user.posts.create!(body: "#{Faker::HarryPotter.quote} #{Faker::Lorem.paragraph}")
#   end
# end

# User.all.each do |user|
#   user.cover_pic = 'https://placeimg.com/770/230/nature'
#   user.save
# end


# like = Like.new
# like.user_id = 26
# like.likeable_type = 'Comment'
# like.likeable_id = 141
# like.save


