class Gallery < ApplicationRecord
  belongs_to :user
  has_many :images, inverse_of: :gallery
  accepts_nested_attributes_for :images, reject_if: :all_blank

  validates_uniqueness_of :title, scope: [:user_id]
end
