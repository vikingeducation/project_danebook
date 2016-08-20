class Photo < ApplicationRecord
  belongs_to :user
  has_many :likes, :as => :likeable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy

  has_attached_file :avatar, :styles => { medium: "300x300", thumb: "150x150", cover: "800x450", profile: "225x300", comment: "58x54"}

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def date
    updated_at.strftime("%m/%d/%Y")
  end
end
