class Photo < ActiveRecord::Base
  has_attached_file :photo, :styles => { thumb: "50x50#", medium: "160x160#" }
  belongs_to :author, :class_name => "User"

  has_many :likes, as: :likable, dependent: :destroy

  validates :author, presence: true
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end
