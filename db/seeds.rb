# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User.destroy_all

# 20.times do
#    User.create(:username => Faker::Internet.user_name,
#                :email => Faker::Internet.email,
#                :password_digest)
# end

  10.times do
    User.create(first_name: Faker::Name.first_name,
                last_name: Faker::Name.last_name,
                email: Faker::Internet.email,
                password: "password",
                password_confirmation: "password")
  end

  User.all.each do |user|
    user.profile.birthday = Faker::Date.between(60.years.ago, 13.years.ago)
    user.profile.college = Faker::Company.name
    user.profile.hometown = Faker::Address.city
    user.profile.current_town = Faker::Address.city
    user.profile.telephone = Faker::PhoneNumber.phone_number
    user.profile.words_to_live_by = Faker::Lorem.sentence
    user.profile.about_me = Faker::Lorem.paragraph(10)
    user.profile.save
  end

  Profile.all.each do |profile|
    rand(2..10).times do
      post = profile.posts.build(:body => Faker::Lorem.paragraph(rand(1..20)))
      post.user_id = User.all.ids.sample
      post.save!
    end
  end
