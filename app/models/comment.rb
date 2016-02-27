class Comment < ActiveRecord::Base
  
  has_many :likes, as: :liking, dependent: :destroy
  belongs_to :commenting, polymorphic: true
  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_one :profile, through: :author
  has_one :avatar, through: :profile
  # delegate :profile, to: :author
  # delegate :avatar, to: :profile
  def posted_on
    "Posted on " + self.created_at.strftime("%A %m/%d/%Y")
  end
end
