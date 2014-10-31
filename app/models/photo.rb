class Photo < ActiveRecord::Base
  has_attached_file :photo, styles: { thumb: "45x45#", small: "90x90#", medium: "270x270#" }
  belongs_to :author, :class_name => "User"

  has_many :likes, as: :likable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :author, presence: true
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates_attachment :photo, presence: true,
                               size: { :in => 0..10.kilobytes }
end
