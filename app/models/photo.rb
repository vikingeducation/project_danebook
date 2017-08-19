class Photo < ApplicationRecord

  belongs_to :user

  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :likes, :as => :likeable, :dependent => :destroy
  has_many :likers, :through => :likes,
                    :source => :user

  validates_presence_of(:user, :image, :image_file_name)

  has_attached_file :image, :styles => { :medium => "500x500",
                                        :thumb => "120x120" }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment :image,
                      :presence => true,
                      :content_type => { :content_type => [ "image/jpeg",
                                                            "image/gif",
                                                            "image/png"] },
                      :size => { :in => 0..500.kilobytes }

  def image_from_url(url)
    self.image = open(url)
  end


end
