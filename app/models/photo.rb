class Photo < ApplicationRecord

  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "130x130#" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def like_list
    likes.map {|like| like.user.profile.name}.join(", ")
  end

end
