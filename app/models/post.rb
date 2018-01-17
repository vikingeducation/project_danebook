class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, :as => :likeable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy

  def self.newsfeed(user)
    users = user.users_friended_by
    posts = users.flat_map {|u| u.posts.take(5) }
    posts.sort_by { |p| p.created_at }
  end
end
