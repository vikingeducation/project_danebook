# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
p "Destroying Users"

User.destroy_all

genders = {0 => "Male", 1 => "Female", 2 => "Other"}

p "Creating Users"
def randomize?
  rand(9) > 4
end
20.times do |i|
  hometown = randomize? ? nil : Faker::Hipster.word
  p User.create(
              email: "foo#{i}@bar.com",
              password: "1234Qwerasdfzxcv",
              password_confirmation: "1234Qwerasdfzxcv",
              profile_attributes:
                {
                  first_name: Faker::Name.first_name,
                  last_name: Faker::Name.last_name,
                  birthday: rand(10000).days.ago.to_date,
                  gender: genders[rand(3)],
                  college: randomize? ? nil : Faker::University.name,
                  hometown: hometown,
                  current_home: randomize? ? hometown : Faker::Hipster.word,
                  phone: randomize? ? hometown : Faker::Hipster.word
                }

            )
end

user_ids = User.pluck(:id)

p "creating posts"
user_ids.each do |u_id|
  rand(20).times do
    Post.create(
      user_id: u_id,
      post_type: "Post",
      body: randomize? ? Faker::Hipster.paragraph(2, false, 4) : Faker::Hacker.say_something_smart,
      likes_count: 0,
      comments_count: 0,
    )
  end
end

image_urls = ["https://s-media-cache-ak0.pinimg.com/736x/9b/79/52/9b795278d51497222d70722e3ab110ca.jpg",
              "https://s-media-cache-ak0.pinimg.com/736x/01/0b/68/010b68214bf1eeb91060732aa58bed1e.jpg",
              "http://www.funny-meme-pictures.com/wp-content/uploads/2013/11/11162013-funny-memes-105.jpg",
              "https://s-media-cache-ak0.pinimg.com/originals/77/92/00/779200532083a9b899047e361e055658.jpg",
              "http://i0.wp.com/pictures.jokofy.com/wp/wp-content/uploads/2015/12/Cute-and-funny-fat-child-meme.jpg?fit=600%2C384",
              "http://www.dumpaday.com/wp-content/uploads/2016/04/funny-25.png"

              ]

p "creating images and friends"
user_ids.each do |u_id|
  rand(3).times do
    gal = Gallery.create(
      user_id: u_id,
      title: Faker::Hipster.words(rand(1..5)).join(" "),
      description: Faker::Hacker.say_something_smart
    )
    image_urls.each do |url|
      Image.create(
        gallery_id: gal.id,
        url: url,
        description: Faker::Hacker.say_something_smart,
      )
    end
    img = gal.images.sample
    img.set_profile_photo = "1"
  end
  10.times do
    Friendify.friendship(User.find_by(id: u_id), User.find_by(id: user_ids.sample))
  end
end

p "SLEEPING UNTIL ALL JOBS COMPLETE"
sleep(1) until Delayed::Job.count < 2

post_ids = Post.pluck(:id)

p "creating comments"
Post.all.each do |post|
  if post.user.friends && post.user.friends.count > 0
    rand(2..10).times do
      p Post.create(
        user_id: post.user.friend_ids.sample,
        post_id: post.id,
        post_type: "Comment",
        body: randomize? ? Faker::Hipster.paragraph(2, false, 4) : Faker::Hacker.say_something_smart,
        likes_count: 0,
        comments_count: 0,
      )
    end
  end
end
