# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'destroying all records'

User.destroy_all
Profile.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all
Photo.destroy_all
Friending.destroy_all

NUM_USERS = 10
NUM_FRIENDINGS = 5
POSTS_PER_USER = (0..4).to_a
COMMENTS_PER_POST = (0..2).to_a
NUM_LIKES_PER_LIKEABLE = (0..5).to_a

puts 'creating users'

users = []

NUM_USERS.times do |i|
  users << User.create( first_name: Faker::Name.first_name,
                        last_name: Faker::Name.last_name, 
                        email: Faker::Internet.email, 
                        password: 'password' 
                      )
end

puts 'creating user profiles'

users.each do |u|
  u.profile = Profile.create( 
                              birth_month: rand(1..12),
                              birth_day: rand(1..31),
                              birth_year: rand(1920..2015),
                              gender: ['Male', 'Female'].sample,
                              college: Faker::University.name,
                              hometown: Faker::Address.city,
                              current_town: Faker::Address.city,
                              phone: Faker::PhoneNumber.phone_number,
                              words_to_live_by: Faker::Hipster.paragraph(3),
                              about_me: Faker::Lorem.paragraph(2),
                              user_id: u.id
                            )
end

puts 'creating friendships'

users.each do |u|
  NUM_FRIENDINGS.times do |n|
    Friending.create(friender_id: u.id, friendee_id: (u.id + n))
  end
end

puts 'creating posts and likes on posts'

users.each do |u|

  POSTS_PER_USER.sample.times do

    u.posts << Post.create( 
                            content: Faker::ChuckNorris.fact,
                            user_id: u.id
                          )

    u.posts.each do |p|

      NUM_LIKES_PER_LIKEABLE.sample.times do |l|
        p.likes << Like.create( 
                                      likeable_type: 'Post',
                                      likeable_id: p.id,
                                      liker_id: users.sample.id
                                    )
      end
    end
  end
end

puts 'creating comments and likes on comments'

users.each do |u|
  u.posts.each do |p|
    COMMENTS_PER_POST.sample.times do
      comment = Comment.create!( 
                                    body: Faker::StarWars.quote,
                                    author_id: u.id,
                                    commentable_id: p.id,
                                    commentable_type: "Post"
                                  )
      p.comments << comment
      p.comments.each do |c|

        NUM_LIKES_PER_LIKEABLE.sample.times do |l|
          c.likes << Like.create( 
                                  likeable_type: 'Comment',
                                  likeable_id: c.id,
                                  liker_id: users.sample.id
                                )
        end
      end
    end
  end
end

puts 'seeds successfully generated'