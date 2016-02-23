class Photo < ActiveRecord::Base
  
  has_attached_file :image, :styles => { :medium => "350x350", :thumb => "200x200" }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :user

  has_many :comments, as: :commentable
  has_many :likes, as: :likeable

  def photo_url(url)
    self.image = open(url)
  end

end
