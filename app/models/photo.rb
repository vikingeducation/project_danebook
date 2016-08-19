class Photo < ApplicationRecord
  belongs_to :user

  accepts_nested_attributes_for :user,
                                :reject_if => :all_blank

  has_attached_file :image, :styles => { :medium => "300x300", :thumb => "100x100" }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
