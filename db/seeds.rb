# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Destroying all users"
User.destroy_all
puts "Destroying all friendships"
Friending.destroy_all


def generate_users
  pw = Faker::Internet.password(8)
  u = User.new(email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: pw, password_confirmation: pw)
  u.build_profile(birthday: Faker::Time.between(DateTime.now - 100, DateTime.now), hometown: Faker::Address.city, current_location: Faker::Address.city, school: Faker::Company.name, motto: Faker::Hipster.sentence(3),  about: Faker::Hipster.paragraph , telephone: Faker::PhoneNumber.cell_phone, gender: %w[male female].sample)
  u.save
end


def generate_friendships
  begin
    friend_initiator = User.all.sample
    friend_receiver = User.all.sample
  end while friend_initiator == friend_receiver
  friend_initiator.friended_users << friend_receiver unless friend_initiator.friended_users.include?(friend_receiver)
end

def generate_posts(user)
  post = user.posts.build(body: Faker::Hipster.sentence(rand(1..3)))
  post.save!
end

20.times {generate_users}
100.times {generate_posts(User.all.sample)}
60.times {generate_friendships}