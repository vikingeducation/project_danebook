puts "Building users..."

15.times do
  user = User.create(first_name: Faker::Pokemon.name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password")
  user.profile = Profile.new( birthday: Time.now, gender: ["Male", "Female", "IDK", "Other"].sample, college: "Buttface University", hometown: "Cool Place USA", city: "Rascal Flats", telephone: "555-EAT-FOOD", words_to_live_by: "MEOWMEOWMEOWMEOWMEOW", about_me: "UGH." )
end

puts "Users created."
puts "Building Candlejack..."

user = User.create(first_name: "Candlejack", last_name: "Martin", email: "cj@aol.com", password: "password")
user.profile = Profile.new( birthday: Time.now, gender: ["Male", "Female", "IDK", "Other"].sample, college: "Buttface University", hometown: "Uncool Place USA", city: "Radlands Bumble USA", telephone: "555-EAT-GLUE", words_to_live_by: "ONCE UPON A HAT THERE WAS ME AND YEAH", about_me: "IDK BRO" )

puts "Candlejack created."
puts "Building posts..."

User.all.each do |user|
  user.authored_posts.create(body: Faker::ChuckNorris.fact)
end

15.times do
  User.all.sample.authored_posts.create(body: Faker::Hacker.say_something_smart)
end

puts "Posts created."
puts "Building comments..."

User.all.each do |user|
  user.authored_posts.each do |post|
    post.comments.create(author_id: User.all.sample.id, body: Faker::Hipster.sentence)
  end
end

15.times do
  Post.all.sample.comments.create(author_id: User.all.sample.id, body: Faker::Hipster.paragraph)
end

puts "Comments created."
puts "Building likes..."

Post.all.each do |post|
  like = Like.new(liker_id: User.all.sample.id)
  post.likes << like
end

Comment.all.each do |comment|
  like = Like.new(liker_id: User.all.sample.id, likable_thing_type: "Comment")
  comment.likes << like
end

puts "Likes built."