class Profile < ApplicationRecord
  belongs_to :user
  has_many :posts

  validate :is_valid_dob?

  validates :first_name,
    length: { maximum: 50 }

  validates :last_name,
    length: { maximum: 50 }

  validates :college,
    length: { maximum: 50 }

  validates :hometown,
    length: { maximum: 50 }

  validates :currently_lives,
    length: { maximum: 50 }

  validates :telephone,
    length: { maximum: 15 }

  validates :words_to_live_by,
    length: { maximum: 1000 }

  validates :about_me,
    length: { maximum: 1000 }

  def name
    if first_name && last_name
      first_name + ' ' + last_name
    elsif first_name
      first_name
    elsif last_name
      last_name
    end
  end

  private

  def is_valid_dob?
    if((birthday.is_a?(DateTime) rescue ArgumentError) == ArgumentError) ||
        (birthday > DateTime.now)
      errors.add(:birthday, 'Sorry, Invalid Date of Birth Entered.')
    end
  end
end
