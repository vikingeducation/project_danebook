# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

FACTOR = 10


puts "Destroying Resources"
if Rails.env == 'development'
  User.destroy_all
  Friending.destroy_all
  Post.destroy_all
  Comment.destroy_all
  Like.destroy_all
end

def create_harry
  User.create!(email: 'harry_potter@hogwarts.edu', password: 'password',
    profile_attributes: {
      first_name: 'Harry',
      last_name: 'Potter',
      birthday: Date.new(1980, 7, 31),
      college: 'Hogwarts School',
      hometown: "Godrick's Hollow",
      currently_lives: "Godrick's Hollow",
      telephone: '867-5309',
      words_to_live_by: 'Lorem ipsum sapientem ne neque dolor erat,eros solet invidunt duo Quisque aliquid leo. Pretium patrioque',
      about_me: 'Lorem ipsum sapientem ne neque dolor erat,eros solet invidunt duo Quisque aliquid leo. Pretium patrioque sociis eu nihil Cum enim ad, ipsum alii vidisse justo id. Option porttitor diam voluptua. Cu Eam augue dolor dolores quis, Nam aliquando elitr Etiam consetetur. Fringilla lucilius mel adipiscing rebum. Sit nulla Integer ad volumus, dicta scriptorem viderer lobortis est Utinam, enim commune corrumpit Aenean erat tellus. Metus sed amet dolore justo, gubergren sed.'
    } )
end

def create_friending(user)
  FACTOR.times do
    otheruser = User.where.not(id: user.id).sample
    user.friendees << otheruser unless user.friends_with?(otheruser)
  end
end

def create_user
  puts 'creating user...'
  User.create(email: Faker::Internet.email, password: 'password',
  profile_attributes: {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birthday: Date.new(1980, 7, 31),
    college: Faker::University.name,
    hometown: Faker::Address.city,
    currently_lives: Faker::Address.city,
    telephone: Faker::PhoneNumber.cell_phone,
    words_to_live_by: Faker::Lorem.sentence,
    about_me: Faker::Lorem.paragraph
  })
end


puts 'creating harry...'
create_harry

puts "Creating Photos"
photo = Photo.new
photo.user = User.first
photo.picture_from_url('http://weknowyourdreams.com/images/space/space-03.jpg')
photo.save!
photo = Photo.new
photo.user = User.first
photo.picture_from_url('http://a1.img.talkingpointsmemo.com/image/upload/c_fill,fl_keep_iptc,g_faces,h_365,w_652/teu84tpl2ujnvxm1ijlg.jpg')
photo.save!

puts 'assign harrys photos'
harry = User.first
harry.profile_photo = Photo.second
harry.cover_photo = Photo.first
harry.save!

puts "Creating Users"

(FACTOR * 10).times do
  create_user
end


User.all.each do |user|
  create_friending(user)
  user.profile_photo = Photo.first
  user.cover_photo = Photo.second
end

def create_random_post
  User.all.sample(1).first.posts.create(post_text: Faker::Lorem.sentences(2))
end

(FACTOR * 10).times do
  create_random_post
end
