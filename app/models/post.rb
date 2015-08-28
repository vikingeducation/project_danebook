class Post < ActiveRecord::Base

  belongs_to :poster, :class_name => 'User'

  has_many :likes, :as => :liked, :dependent => :destroy
  has_many :likers, :through => :likes, :source => :user

  has_many :comments, :as => :commentable, :dependent => :destroy

  validates :body, :poster_id, :presence => :true
  validates :body, :length => { in: 1..255 }


  def self.get_newsfeed_posts(friend_ids)
    Post.where('poster_id IN (?) AND created_at >= ?', friend_ids, 7.days.ago).
          order(:created_at => :desc).
          limit(10)
  end

  def render_date
    self.created_at.to_date.to_formatted_s(:long_ordinal)
  end

end
