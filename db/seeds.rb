# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Deleting users"
User.destroy_all
Profile.destroy_all
Post.destroy_all


puts "Creating users"
3.times { |i| User.create(:email => "foo#{i}@onet.pl", :password => "lol#{i}", :password_confirmation => "lol#{i}") }

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
    puts "#{u.email}"
    puts "#{u.posts.last.body}"
    u.save!
  end
end
