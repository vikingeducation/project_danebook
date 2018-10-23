# existing local user seeds:
# User.create!([
#   {email: "hannah@hogwarts.edu", password_digest: "$2a$10$.7iJC4yhj5erimvvY4bG8.K8KYjdavkzePK5j.0zNK/CYPd/s3bqG", name: "Hannah Abbott", birthday: "1997-12-01", hometown: "Ollivanders", current_town: "Eeylops Owl Emporium", college: "Eastern Georgia University", phone: "(995) 166-6751 x332", quote: "Dark and difficult times lie ahead. Soon we must all face the choice between what is right and what is easy.", bio: "Ullam consequuntur et harum error debitis beatae. Ut ex quas aut. Ipsum facilis tempore autem labore. Ut adipisci in nobis voluptatum et. Explicabo saepe fuga.", headshot_pic: "http://4.bp.blogspot.com/-5ii1ySW50g8/Th27ayJPJKI/AAAAAAAALQ0/VYDhh1eTgys/s1600/Hannah_Abbott.jpg", cover_pic: "https://placeimg.com/770/230/nature"},
#   {email: "fang@hogwarts.edu", password_digest: "$2a$10$NoB0/Ey2baTULJ5T/z6SK.Ftj2cTKsauBXkYe1Q0Bp8J8yWk6qQOS", name: "Fang", birthday: "1999-06-15", hometown: "Number 12, Grimmauld Place", current_town: "The Hog's Head", college: "East Idaho College", phone: "144.797.0800 x9700", quote: "I solemnly swear that I am up to no good.", bio: "Iusto tenetur et. Enim eligendi necessitatibus fugiat rerum omnis voluptatem dolor. A molestiae dolorem provident qui voluptatem sed odit. Incidunt ipsa aut eos impedit ad rerum. Voluptatem dolor dolorem dolorem est.", headshot_pic: "https://i.pinimg.com/originals/e1/a1/17/e1a1171050ba63faa045f988f019d2ce.jpg", cover_pic: "https://placeimg.com/770/230/nature"},
#   {email: "quirrell@hogwarts.edu", password_digest: "$2a$10$.mCyFn5r/MKL7K1d5cFgaelS56ynS9UKd/KFC2UOj.MiJkNA2lL3K", name: "Professor Quirrell", birthday: "1998-01-21", hometown: "Hogsmeade", current_town: "The Hog's Head", college: "Southern Murray College", phone: "1-847-347-9642 x9227", quote: "It is our choices, Harry, that show what we truly are, far more than our abilities.", bio: "Totam sunt atque neque rerum. Eos facere quis vel asperiores animi vitae. Sit inventore minus in.", headshot_pic: "https://qph.fs.quoracdn.net/main-thumb-t-58106-200-lARLXZnHlUNXA73uHWPs7zEQJAvH0YSr.jpeg", cover_pic: "https://placeimg.com/770/230/nature"},
#   {email: "heromine@hogwarts.edu", password_digest: "$2a$10$QKIkI9l8LR/C7kPj0cgV2eZs3AxRiL4pfbwki2ZuDVpy0ff/qdONG", name: "Heromine Granger", birthday: "1998-05-15", hometown: "Potage's Cauldron Shop", current_town: "Wiseacre's Wizarding Equipment", college: "Altenwerth Academy", phone: "676-939-5664 x342", quote: "You sort of start thinking anything’s possible if you’ve got enough nerve.", bio: "Et velit aut quisquam quo ullam repellat. Veritatis magnam aut deleniti. Nisi nihil eos doloremque sed. Assumenda eveniet nemo.", headshot_pic: "http://cdn-img.instyle.com/sites/default/files/styles/480xflex/public/images/2010/gallery/110910-Hermione-2-400_0.jpg?itok=aAfIEO3X", cover_pic: "https://placeimg.com/770/230/nature"},
#   {email: "harry@hogwarts.edu", password_digest: "$2a$10$GEVEtSSLnqnDTsPXXj8ob.wt5Geo/Yh6E9tW.35UPN8bpWT3oXXiq", name: "Harry Potter", birthday: "1998-07-31", hometown: "Little Whinging", current_town: "with Ginny", college: "Hogwarts", phone: "", quote: "Er, um...", bio: "", headshot_pic: "https://pbs.twimg.com/profile_images/876137969777823745/BE-fu86q_400x400.jpg", cover_pic: "https://placeimg.com/770/230/nature"},
#   {email: "moody@hogwarts.edu", password_digest: "$2a$10$BsAEwnobPywJhmsf9YFmL.HzDlIBZz4QoFwHMphOy9/NelQQeqVy2", name: "Alastor (Mad-Eye) Moody", birthday: "1996-03-11", hometown: "Weasleys' Wizard Wheezes", current_town: "Castlelobruxo", college: "Southern Schuster", phone: "1-156-464-6969", quote: "Happiness can be found even in the darkest of times if only one remembers to turn on the light.", bio: "Cumque nesciunt impedit. Incidunt enim molestiae ad. Id delectus laborum voluptates harum aut. Natus ipsa officiis voluptatem nemo.", headshot_pic: "https://vignette.wikia.nocookie.net/characters/images/b/b4/Alastor_Moody.jpg/revision/latest?cb=20171118203432", cover_pic: "https://placeimg.com/770/230/nature"}
# ])


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
    # headshot_pic: 'https://placeimg.com/150/150/people',
    # cover_pic: 'https://placeimg.com/770/230/nature',
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
comments = Comment.all.sample(comment_count / 2)
user_count = User.all.count
users = User.all.sample(user_count * 0.8)
users.each do |user|
  comments.each do |comment|
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
