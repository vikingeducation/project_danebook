class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :likes, :as => :likeable, :dependent => :destroy
  has_many :likers, :through => :likes,
                    :source => :user

  validates_presence_of(:user)

  validates :body, :presence => true

  def self.posts_of_friended_users(user)
    where(:user_id => user.friended_users.pluck(:id)).order(updated_at: :desc)
  end


  def ten_recent_posts_of_uniq_users(user)
      users = [user.id]
      users_posts = []
      Post.posts_of_friended_users(user).each do |post|
        unless users.include? post.user_id
          users << post.user_id
          users_posts << post unless users_posts.length > 10
        end
      end
      users_posts
  end

end
