class Photo < ActiveRecord::Base
  
  has_attached_file :image, :styles => { :large => "500x500", :medium => "350x350", :thumb => "200x200" }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  def photo_url(url)
    self.image = open(url)
  end

end
