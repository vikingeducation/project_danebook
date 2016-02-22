class Photo < ActiveRecord::Base

  has_attached_file :image, 
                    styles: { medium: "300x300", thumb: "100x100" }

  validates_attachment_content_type :image, 
                                    content_type: /\Aimage\/.*\Z/

  attr_accessor :delete_image

  before_validation { image.clear if delete_image == '1' }


  belongs_to :user


end
