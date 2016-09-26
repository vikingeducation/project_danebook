class Post < ApplicationRecord
  belongs_to :user

  validates :description, length: {minimum: 1}
  has_many :comments, class_name: "Comment"

  has_many :likes, :as => :likeable, class_name: "Liking"

  has_many :comments, :as => :commentable, class_name: "Comment"

  has_one :photo, :as => :photoable, class_name: "Photo", inverse_of: :photoable
  accepts_nested_attributes_for :photo

  def already_likes?
    !likes.empty?
  end

  def has_photo?
    !!(self.photo.nil?)
  end

  def self.send_trigger_email(id, post)
    user = User.find(id)
    UserMailer.trigger(user, post).deliver
  end

  def self.recent_posts(dayz_ago)
    if dayz_ago
      where("created_at > ?", (dayz_ago).days.ago)
    else
      raise
    end
  end
end
