include ActionView::Helpers
require 'open-uri'

User.destroy_all
Comment.destroy_all
Post.destroy_all
Like.destroy_all
Profile.destroy_all
Friendship.destroy_all
Photo.destroy_all

# set default profile photo
Photo.create(image: open('app/assets/images/blank_profile_photo.jpg'))

# set default cover photo
Photo.create(image: open('app/assets/images/blank_cover_photo.jpg'))

# create users
20.times do |n|

  User.create(:username => "foo#{n}",
              :email => "foo#{n}@bar.com",
              :password => "1234",
              :password_confirmation => "1234",
              :first_name => "foo#{n}",
              :last_name => "bar")

  Profile.last.update(:about_me => "I am the #{n}th
                                   person signed up",
                      :words_to_live_by => "Be No. #{n}!",
                      :college => "Hogwarts")
end


# create 30 posts
30.times do |n|
  Post.create(:user_id => User.ids.sample,
              :body => "This is post #{n}")
end

# create 25 comments on comments and posts each
50.times do |n|

  if n % 2 == 0 && Comment.all.count > 0
    Comment.create(:user_id => User.ids.sample,
                  :body => "comment #{n} on a comment",
                  :commentable => Comment.find(Comment.ids.sample))
  elsif Post.all.count > 0
    Comment.create(:user_id => User.ids.sample,
                  :body => "comment #{n} on a post",
                  :commentable => Post.find(Post.ids.sample))
  end

end

# create 50 likes on comments and posts each
100.times do |n|

  if n % 2 == 0 && Comment.all.count > 0
    Like.create(:user_id => User.ids.sample,
                :liking => Comment.find(Comment.ids.sample))
  elsif Post.all.count > 0
    Like.create(:user_id => User.ids.sample,
                :liking => Post.find(Post.ids.sample))
  end

end

# create less than 50 Pending friendships
50.times do |n|
  Friendship.create(:initiator_id => User.ids.sample,
                    :acceptor_id => User.ids.sample,
                    :status => 'Pending')
end

# Create 20 accepted friendships
20.times do |n|
  Friendship.find(Friendship.ids.sample).
              update(:status => 'Accepted')
end

