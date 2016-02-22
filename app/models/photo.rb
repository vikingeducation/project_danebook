class Photo < ActiveRecord::Base

  has_attached_file :image,
                    # source_file_options: { width: "200px"},
                    styles: { large: "700x700", 
                              medium: "300x300#", 
                              thumb: "100x100#" }

  validates_attachment_content_type :image,
                                    presence: {message: "Please select photo"},
                                    content_type: /\Aimage\/.*\Z/


  attr_accessor :delete_image

  before_validation { image.clear if delete_image == '1' }


  belongs_to :user


end
