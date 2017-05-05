class Profile < ApplicationRecord
  attr_reader :image_remote_url

  belongs_to :user, inverse_of: :profile

  has_many :initiated_friendships, through: :user

  has_attached_file :avatar,
    styles: { medium: '300x300#', thumb: '26x36', small: '150x150#' },
    default_url: 'avatar_missing.png'

  has_attached_file :cover,
    styles: { medium: '900x300'},
    default_url: 'cover_missing.png'

  validates_attachment :cover,
    content_type: { content_type: /\Aimage\/.*\Z/},
    size: { in: 0..3.5.megabytes}

  validates_attachment :avatar,
    content_type: { content_type: /\Aimage\/.*\Z/},
    size: { in: 0..2.megabytes}
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
