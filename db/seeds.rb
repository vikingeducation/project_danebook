puts 'Deleting existing...'

resources = [User, Post]
resources.each do |resource|
  puts "#{resource.count} #{resource}s"
  resource.destroy_all
end

puts '','Building new...'
puts 'Users w/o profiles'
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
    headshot_pic: Faker::LoremPixel.image("150x150", false, 'people'),
    cover_pic: 'http://via.placeholder.com/770x230',
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
    post.comments.create!(body: "#{Faker::Lorem.paragraph}.", user_id: User.all.sample.id)
    post.likes.create!(user_id: User.all.sample.id)
  end
end

# User.all.each do |user|
#   3.times do
#     user.posts.create!(body: "#{Faker::HarryPotter.quote} #{Faker::Lorem.paragraph}")
#   end
# end

# User.all.each do |user|
#   user.headshot_pic = 'headshot.png'
#   user.save
# end



