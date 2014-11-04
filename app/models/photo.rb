class Photo < ActiveRecord::Base
	has_attached_file :photo
	belongs_to :user

	has_many :comments, as: :commentable, dependent: :destroy


	validates_attachment :photo, presence: true, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end
