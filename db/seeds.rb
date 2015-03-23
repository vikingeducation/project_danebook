# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Post.destroy_all
Like.destroy_all
Comment.destroy_all

45.times do
  User.create(
    :email => Faker::Internet.email,
    :password_digest => Faker::Lorem.word,
    :first_name => Faker::Name.first_name,
    :last_name => Faker::Name.last_name
    )
end

User.all.each do |user|
  Profile.create(
    :currenttown => Faker::Address.city,
    :hometown => Faker::Address.city,
    :email => user.email,
    :user_id => user.id,
    :aboutme => Faker::Lorem.sentence,
    :words => Faker::Lorem.sentence,
    :telephone => Faker::Lorem.word
    )
end

210.times do 
    @user = User.all.sample
    Post.create(
        :user_id => @user.id,
        :content => Faker::Lorem.sentence
        )
end

400.times do

    @user = User.all.sample
    @post = Post.all.sample
    Like.create(
        :post_id => @post.id,
        :user_id => @user.id
        )
end

200.times do 
    @post = Post.all.sample
    @user = User.all.sample
    Comment.create(
        :post_id => @post.id,
        :user_id => @user.id,
        :content => Faker::Lorem.sentence
        )
end
