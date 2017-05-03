class Profile < ApplicationRecord
  attr_reader :image_remote_url

  belongs_to :user, inverse_of: :profile
  has_many :initiated_friendships, through: :user
  belongs_to :avatar, foreign_key: :avatar_id, class_name: 'Photo', optional: true
  belongs_to :cover, foreign_key: :cover_id, class_name: 'Photo', optional: true
  validates :first_name, :last_name, :sex, :birthdate, presence: true, on: :create
  validate :birthdate_not_in_future, on: :create
  validates :sex, inclusion: {in: %w(female male) }, on: :create


  def image_remote_url=(url_value)
    self.image = URI.parse(url_value)
  end

  def birthday
    self.birthdate.strftime('%-d %B %Y') if self.created_at
  end

  private

  def birthdate_not_in_future
    if birthdate.present? && birthdate > Date.today
      errors.add(:birthdate, "It seems you're from the future. Please contact us directly.")
    end
  end



end
