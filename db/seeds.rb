# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Deleting records "
User.destroy_all
Profile.destroy_all
Post.destroy_all
Friending.destroy_all


puts "Creating users"
9.times { |i| User.create(:email => "foo#{i}@onet.pl", :password => "lol#{i}", :password_confirmation => "lol#{i}") }

puts "Creating users profiles"
User.all.each do |user|
  profile = user.build_profile
  profile.birth_day = rand(1..27)
  profile.birth_month = rand(1..12)
  profile.birth_year = rand(1970..2005)
  profile.gender = ['male','female'][rand(0..1)]
  profile.first_name = "Foo#{rand(1..27)}"
  profile.last_name = "Zoo#{rand(1..27)}"
  user.profile.save
end

puts "Creating posts"
User.all.each do |u|

  4.times do
    u.posts.build(:body => "I keep trying and #{rand(34)}")
    u.save!
  end
end

puts "Creating comments"
Post.all.each do |post|
  n = rand(0..2)
  n.times do
    post.comments.build(:body => "This is my comment no #{rand(12334)}", :user_id => User.pluck(:id).sample)
    puts "#{post.inspect}"
    post.save!
  end
end


puts "Creating friends"

User.all.each do |user|
  3.times do
    random_userid = User.pluck(:id).sample
    if Friending.all.where(:friender_id => random_userid).any? && user.id != random_userid
      next
    else
      Friending.create(friend_id: user.id, friender_id: random_userid)
    end
  end
end
