# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Destroying users.."
Timeline.destroy_all
User.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all

#Seed a user.
puts "Seeding a user.."
foobar = User.create!(email: 'foobar@barbaz.com',
                     #Use pw + pwc for seeds. Use pw_digest for fixtures.
                     password: 'foobar',
                     password_confirmation: 'foobar',
                     activated: true,
                     activated_at: rand(365).days.ago)
foobar.build_profile({ first_name: 'Foobar',
                       last_name: 'Barbaz' }).save

puts "Seeding another user.."
cj = User.create!(email: 'cjvirtucio@mail.com',
                     #Use pw + pwc for seeds. Use pw_digest for fixtures.
                     password: 'example',
                     password_confirmation: 'example',
                     activated: true,
                     activated_at: rand(365).days.ago)
cj.build_profile({ first_name: 'CJ',
                   last_name: 'Example' }).save

#Seed more users.
puts "Seeding more users.."
99.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "fake_email_#{n+1}@fmail.com"
  password_digest = User.digest('password')
  user = User.create!(email: email,
              password: 'foobar',
              password_confirmation: 'foobar',
              activated: true,
              activated_at: rand(365).days.ago)
  user.build_profile({ first_name: first_name, last_name: last_name }).save
  3.times do
    user.posts.create!(title: Faker::Lorem.words(2), body: Faker::Lorem.paragraph(5))
  end
  3.times do
    random = [:first, :second, :third].sample
    (user.posts.send(random)).comments.create!(user: user, body: Faker::Lorem.paragraph(2))
  end
end