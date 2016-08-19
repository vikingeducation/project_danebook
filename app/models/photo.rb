class Photo < ApplicationRecord
  has_one :post, :as => :postable

  belongs_to :user

  has_attached_file :image, :styles => { :index => "150x120", :timeline => "60x50" }, default_url: "https://s3.amazonaws.com/viking_education/web_development/web_app_eng/icon_photo_small.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
