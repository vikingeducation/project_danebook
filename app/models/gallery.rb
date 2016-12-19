class Gallery < ApplicationRecord
  validate :protect_profile_gallery, on: :update

  belongs_to :user
  has_many :images, -> { order(:created_at) }, inverse_of: :gallery, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: :all_blank

  validates_uniqueness_of :title, scope: [:user_id]

  def protect_profile_gallery
    if self.changes[:title] && self.changes[:title].include?("Profile Images")
      errors.add(:title, :invalid, message: "cannot be modified for profile gallery")
    end
  end

  def destroy
    raise "Cannot delete profile gallery" unless user.nil? || self.title != "Profile Images"
    super
  end
end
