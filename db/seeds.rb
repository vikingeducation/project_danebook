# User.destroy_all
Profile.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all
Friendship.destroy_all
Photo.destroy_all

# puts "creating 10 users.."
# 10.times do
#   User.create(first_name: Faker::Name.first_name,
#               last_name: Faker::Name.last_name,
#               email: Faker::Internet.email,
#               password: "password123",
#               birthday: Faker::Date.between(50.years.ago, 5.years.ago),
#               gender_cd: rand(2)
#               )
# end

puts "creating #{User.all.count} profiles.."
puts "creating 2 posts per user"
User.all.each do |u|
  Profile.create(user_id: u.id, college: Faker::University.name,
                 hometown: "#{Faker::Address.city}, #{Faker::Address.state}",
                 address: "#{Faker::Address.city}, #{Faker::Address.state}",
                 phone: Faker::PhoneNumber.cell_phone,
                 status: Faker::Hipster.sentence,
                 about: Faker::Hipster.paragraph
               )
  2.times { u.posts << Post.new(text: Faker::Hipster.paragraph) }
end

puts "creating 4 likes on posts per user"
User.all.each do |u|
  post_ids = Post.pluck(:id).shuffle
  4.times { Like.create(user_id: u.id, likable_id: post_ids.pop, likable_type: "Post") }
end

puts "creating 4 comments per user"
User.all.each do |u|
  post_ids = Post.pluck(:id).shuffle
  4.times { Comment.create(user_id: u.id, commentable_id: post_ids.pop, text: Faker::Hipster.sentence, commentable_type: "Post") }
end

puts "creating 4 likes on comments per user"
User.all.each do |u|
  comment_ids = Comment.pluck(:id).shuffle
  4.times { Like.create(user_id: u.id, likable_id: comment_ids.pop, likable_type: "Comment") }
end

puts "creating friends"
User.all.each do |u|
  other_users = User.pluck(:id).shuffle - [u.id]
  4.times { Friendship.create(initiator: u.id, recipient: other_users.pop) }
end


puts "creating 4 photos for each user"
User.all.each do |u|
  4.times do
    @photo = Photo.new(user_id: u.id)
    @photo.image = File.open('/Users/Deepak/Pictures/hp.jpg')
    @photo.save!
  end
end

puts "creating 2 comments for each photo"
User.all.each do |u|
  photo_ids = Photo.pluck(:id).shuffle
  2.times { Comment.create(user_id: u.id, commentable_id: photo_ids.pop, text: Faker::Hipster.sentence, commentable_type: "Photo") }
end

puts "creating 2 likes for photo per user"
User.all.each do |u|
  photo_ids = Photo.pluck(:id).shuffle
  2.times { Like.create(user_id: u.id, likable_id: photo_ids.pop, likable_type: "Photo") }
end

