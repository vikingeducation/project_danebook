class Post < ActiveRecord::Base
  has_many :comments, -> { order('created_at ASC') }, as: :commenting, dependent: :destroy
  has_many :likes, as: :liking, dependent: :destroy
  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_one :profile, through: :author
  has_one :avatar, through: :profile

  
  def has_likes?
    self.likes.count > 0
  end

  def posted_on
    "#{self.class}ed on " + self.created_at.strftime("%A %m/%d/%Y")
  end
end
