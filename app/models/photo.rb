class Photo < ActiveRecord::Base
  has_attached_file :photo, styles: { thumb: "45x45#", small: "90x90#", medium: "180x180#" }
  belongs_to :author, :class_name => "User"

  has_many :likes, as: :likable, dependent: :destroy

  validates :author, presence: true
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end
