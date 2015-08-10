class Photo < ActiveRecord::Base
  has_attached_file :uploaded_file
  validates_attachment_content_type :uploaded_file, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


  has_many :comments, -> { order('created_at ASC') }, as: :commentable, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy
  has_many :people_who_like, through: :likes, source: :user
  belongs_to :uploader, class_name: "User", foreign_key: :user_id
  validates :uploader, presence: true

  def uploaded_on
    "Uploaded on " + self.created_at.strftime("%A %m/%d/%Y")
  end

  def has_likes?
    self.likes.count > 0
  end
end
