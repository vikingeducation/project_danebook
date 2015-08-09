# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Profile.destroy_all
Like.destroy_all
Comment.destroy_all
Post.destroy_all

Multiplier = 10
duty_types = ["Post", "Comment"]

(5*Multiplier).times do 
  password = Faker::Internet.password
  user = User.create(:first_name => Faker::Name.first_name, 
                  :last_name => Faker::Name.last_name,
                  :email => Faker::Internet.email,  
                  :password => password, 
                  :password_confirmation => password)
  user.save
  user.profile.update(
                     :user_id => user.id,
                     :birthday => Faker::Date.between(14.years.ago, 80.years.ago),
                     :college => Faker::Lorem.word,
                     :photo_url => Faker::Avatar.image, 
                     :current_town => Faker::Address.city, 
                     :hometown => Faker::Address.city, 
                     :telephone => Faker::PhoneNumber.cell_phone,
                     :words_to_live_by => Faker::Company.catch_phrase,
                     :about_me => Faker::Lorem.paragraph(8, true)
                     )

end

all_user_ids = User.select("id")

(13*Multiplier).times do
  post = Post.new(
                  user_id: all_user_ids.sample.id,
                  body: Faker::Lorem.paragraph(6, true),
                  posted_id: all_user_ids.sample.id
                  )
  post.save

  rand(0..10).times do 
    pc = post.comments.new(
                           :author_id => all_user_ids.sample.id,
                           :body => Faker::Lorem.paragraph(rand(2..10), true)
                           )
    pc.save
  end                 
end

count_of_post = Post.count
count_of_comment = Comment.count

(15*Multiplier).times do
  p = Comment.find(rand(1...Comment.count))
  c = p.comments.new(
                    :author_id => all_user_ids.sample.id,
                    :body => Faker::Lorem.paragraph(rand(2..10), true)
                    )  
  c.save
end



(20*Multiplier).times do
  duty = duty_types.sample
  if duty == "Post"
      duty_id = Post.offset(rand(count_of_post)).first.id
  else
      duty_id = Comment.offset(rand(count_of_comment)).first.id
  end

  l = Like.create(
                  duty_type: duty, 
                  duty_id: duty_id,
                  user_id: rand(0...50)
                  )
  l.save
end

count_of_users = User.count
200.times do
  user1_id = User.offset(rand(count_of_users)).first.id
  user2_id = User.offset(rand(count_of_users)).first.id
  Friending .create(friender_id: user1_id, friend_id: user2_id) if user1_id != user2_id
end



  