# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
p "Clearing data..."
User.destroy_all
Profile.destroy_all
Post.destroy_all
Comment.destroy_all
Friendship.destroy_all

MULTIPLIER = 5

p "Creating users..."
(10 * MULTIPLIER).times do |i|
  u = User.new
  u.first_name = Faker::Name.first_name
  u.last_name = Faker::Name.last_name
  u.email = Faker::Internet.email
  u.gender = ["Male", "Female"].sample
  u.password = Faker::Internet.password(8, 12)
  u.birthday = Time.now
  u.created_at = Time.now
  u.updated_at = Time.now
  u.save!
  u.create_profile(
                  college: Faker::Name.first_name,
                  telephone: Faker::PhoneNumber.phone_number,
                  hometown: "#{Faker::Address.city}, #{Faker::Address.state}",
                  current_location: "#{Faker::Address.city}, #{Faker::Address.state}",
                  about_me: Faker::Lorem.paragraph,
                  words_to_live_by: Faker::Lorem.paragraph
                  )
end

(30 * MULTIPLIER).times do |i|
  Post.create(
              :user_id => User.all.sample.id,
              :body => Faker::Lorem.paragraph
              )
end

(50 * MULTIPLIER).times do |i|
  Comment.create(
                 :user_id => User.all.sample.id,
                 :body => Faker::Lorem.sentence,
                 :commentable_id => Post.all.sample.id,
                 :commentable_type => "Post"
                 )
end

(50 + MULTIPLIER).times do |i|
  type = ["Post", "Comment"].sample
  if type == "Post"
    Like.create(
              :user_id => User.all.sample.id,
              :likeable_id => Post.all.sample.id,
              :likeable_type => type)
  else
    Like.create(
              :user_id => User.all.sample.id,
              :likeable_id => Comment.all.sample.id,
              :likeable_type => type)
  end
end

(10 * MULTIPLIER).times do |i|
  Friendship.create(
                    :user_id => User.all.sample.id,
                    :friend_id => User.all.sample.id)
end

