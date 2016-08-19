class Photo < ActiveRecord::Base
  has_attached_file :file, :styles => { :medium => "300x300", :thumb => "100x100", large: "800x750" }
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  validates :file, presence: true
  validates :file_file_name, presence: true
  validates :file_content_type, presence: true
  validates :file_file_size, presence: true
  validates :user_id, presence: true
end
