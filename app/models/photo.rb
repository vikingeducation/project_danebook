class Photo < ActiveRecord::Base
  has_attached_file :uploaded_file, storage: :s3, styles: {medium: "200x200", small: "100x100"}
  validates_attachment_content_type :uploaded_file, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_size :uploaded_file, :less_than => 10.megabytes

  has_many :comments, -> { order('created_at ASC') }, as: :commentable, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy
  has_many :people_who_like, through: :likes, source: :user

  belongs_to :uploader, class_name: "User", foreign_key: :user_id
  belongs_to :author, class_name: "User", foreign_key: :user_id

  validates :uploader, presence: true
  has_one :user_profile_photo,
           class_name: "User",
           foreign_key: :profile_photo_id,
           dependent: :nullify

  has_one :user_cover_photo,
           class_name: "User",
           foreign_key: :cover_photo_id,
           dependent: :nullify

  def uploaded_on
    "Uploaded on " + self.created_at.strftime("%A %m/%d/%Y")
  end

  def has_likes?
    self.likes.count > 0
  end
end
