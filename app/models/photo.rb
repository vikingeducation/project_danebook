class Photo < ApplicationRecord
  has_one :post, :as => :postable
  has_one :used_as_profile, class_name: :profile, foreign_key: :prof_photo_id
  has_one :used_as_cover, class_name: :profile, foreign_key: :cover_photo_id
  belongs_to :user

  has_attached_file :image, :styles => { :index => "150x120", :timeline => "60x50", :profile => "150x150", :post => "75x75" }, default_url: "https://s3.amazonaws.com/viking_education/web_development/web_app_eng/icon_photo_small.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
