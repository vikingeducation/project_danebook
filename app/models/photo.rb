class Photo < ApplicationRecord
  belongs_to :user

  has_attached_file :picture, styles: { thumb: "100x100",
                                        small: "200x200",
                                        large: "600x600",
                                       avatar: "185x225",
                                       banner: "x450" },
                                  default_url: "/images/:style/missing.png"


  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/


end
