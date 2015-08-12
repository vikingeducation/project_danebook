class Photo < ActiveRecord::Base

  has_attached_file :image,
                    styles: { large: "700x700",
                              medium: "300x300",
                              thumb: "100x100" },
                    default_url: "/images/:style/missing.png"
  belongs_to :user
  has_one :profile

  validates_attachment_content_type :image,
                                    content_type: /\Aimage\/.*\Z/

end
