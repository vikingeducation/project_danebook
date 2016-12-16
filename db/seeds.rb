User.destroy_all
Profile.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all
Friendship.destroy_all
Photo.destroy_all

puts "creating 10 users.."
10.times do
  user = User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              password: "password123",
              birthday: Faker::Date.between(50.years.ago, 5.years.ago),
              gender_cd: rand(2)
              )
  user.created_at = (10).days.ago
  user.save
end

puts "creating #{User.all.count} profiles.."
puts "creating 2 posts per user"
User.all.each do |u|
  profile = Profile.create(user_id: u.id, college: Faker::University.name,
                 hometown: "#{Faker::Address.city}, #{Faker::Address.state}",
                 address: "#{Faker::Address.city}, #{Faker::Address.state}",
                 phone: Faker::PhoneNumber.cell_phone,
                 status: Faker::Hipster.sentence,
                 about: Faker::Hipster.paragraph
               )
  profile.created_at = (10).days.ago
  profile.save
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

profile_imgs = [
'https://cdn.pixabay.com/photo/2016/08/20/05/38/avatar-1606916_960_720.png',
'http://orig02.deviantart.net/57a4/f/2014/024/2/2/chapsunited_avatar___duoduo66_by_duoduo66-d73l0cj.png',
'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Vincent_Zirah_03.svg/1024px-Vincent_Zirah_03.svg.png',
'https://c2.staticflickr.com/8/7371/10211905066_f555c8ffc5_b.jpg',
'https://c8.staticflickr.com/4/3775/10830127815_5d94e21383_c.jpg',
'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcT_MD807yGqGdKuK-bvaSDNQlmF4aTQj_8I0hQdqg53YvLmf97G',
'https://upload.wikimedia.org/wikipedia/commons/9/91/Stark_Sands_Headshot.jpg',
'https://upload.wikimedia.org/wikipedia/commons/d/dc/Rachelle_Dekker_Author_Headshot.jpg',
'https://upload.wikimedia.org/wikipedia/commons/d/db/Kublai_Khan_square.jpg',
'https://c2.staticflickr.com/4/3821/19903674202_9aab379305_b.jpg'
]

cover_imgs = [
'http://labaiadeicapitani.net/wp-content/uploads/2014/02/Boy-and-UFO-iPad-4-wallpaper-ilikewallpaper_com_1024-1024x300.jpg',
'http://agro.biodiver.se/wp-content/uploads/2010/09/catie-pano2-1024x300.jpg',
'http://www.freewebheaders.com/wordpress/wp-content/gallery/forests-fields/trees-rocks-header-9053-1024x300.jpg',
'http://www.saulpartners.com/wp-content/uploads/2015/09/Big-Data-1024x300.jpg',
'http://www.edgefinite.com/wp-content/uploads/2015/09/blue-computer-business-background-header-1024x300.jpg',
'http://www.freewebheaders.com/wordpress/wp-content/gallery/chess/chess-recreation-header-6613-1024x300.jpg',
'http://visitohrid.org/wp-content/uploads/2014/04/2014-03-21-17.13.29-1024x300.jpg',
'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQ6uJI__DDvb47sc4xeWXO1MlFI_ioe7MJfon8hT6fEPkhdlDS_',
'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSyujAgUxpgRdIHgtvRUZ7wna0Qf8avKsERIoyIGkwjgnPn80jvAg',
'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTxDdCW722a20-9r9tUySpp04UvcOPNL44No-HD9mnR8LxvGCGL'
]

imgs = [
'https://c2.staticflickr.com/8/7559/15756506355_b8ed9d39a2.jpg',
'https://c1.staticflickr.com/1/54/125036720_e20ad38a7e.jpg'
]
puts "creating 3 photos for each user"
User.all.each_with_index do |u, i|
  1.times do
    @photo = Photo.new(user_id: u.id)
    @photo.image_from_url(profile_imgs[i])
    # @photo.image = File.open('/Users/Deepak/Pictures/hp.jpg')
    @photo.save
    u.profile_photo = @photo
    u.save!
  end
  1.times do
    @photo = Photo.new(user_id: u.id)
    @photo.image_from_url(cover_imgs[i])
    # @photo.image = File.open('/Users/Deepak/Pictures/cover.jpg')
    @photo.save
    u.cover_photo = @photo
    u.save!
  end
  1.times do
    @photo = Photo.new(user_id: u.id)
    @photo.image_from_url(imgs[i%2])
    #@photo.image = File.open('/Users/Deepak/Pictures/snowman.jpg')
    @photo.save
  end
  puts "sleeping for 1 sec"
  sleep 1
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

def rand_time(from, to=Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end
def rand_in_range(from, to)
  rand * (to - from) + from
end
puts "faking creating dates of posts, likes and commets"
Post.all.each do |p|
  post_date = rand_time(10.days.ago)
  p.created_at = post_date
  p.save!
  p.comments.all.each do |c|
    comment_date = rand_time(post_date)
    c.created_at = comment_date
    c.save!
    c.likes.all.each do |cl|
      cl.created_at = rand_time(comment_date)
      cl.save!
    end
  end
  p.likes.all.each do |l|
    like_date = rand_time(post_date)
    l.created_at = like_date
    l.save!
  end
end
Photo.all.each do |p|
  post_date = rand_time(10.days.ago)
  p.created_at = post_date
  p.save!
  p.comments.all.each do |c|
    comment_date = rand_time(post_date)
    c.created_at = comment_date
    c.save!
    c.likes.all.each do |cl|
      cl.created_at = rand_time(comment_date)
      cl.save!
    end
  end
  p.likes.all.each do |l|
    like_date = rand_time(post_date)
    l.created_at = like_date
    l.save!
  end
end

