class Photo < ActiveRecord::Base
  
  has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "100x100" }

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  belongs_to :user

  has_many :comments, as: :commentable
  has_many :likes, as: :likeable

  def photo_url(url)
    self.avatar = open(url)
  end

end
