class Comment < ActiveRecord::Base
  
  has_many :likes, as: :liking, dependent: :destroy
  belongs_to :commenting, polymorphic: true
  belongs_to :author, class_name: "User", foreign_key: :user_id

  def posted_on
    "Posted on " + self.created_at.strftime("%A %m/%d/%Y")
  end
end
