class Photo < ApplicationRecord
  has_attached_file :image, styles: { medium: "300x300>", small: "15ox150>", thumb: "67x67>", profile: "168x168>", cover: "1170x370>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  has_one :activity, :as =>:postable
  has_one :owner, through: :activity, source: :author

  def content
    ActionController::Base.helpers.image_tag(image.url(:medium), class: "img-responsive")
  end

end
