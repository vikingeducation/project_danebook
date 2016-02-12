class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile

  validates :gender,
    inclusion: { in: %w(Male Female) },
    allow_nil: true,
    allow_blank: true
  validates :college, :from, :lives,
    length: { maximum: 36 },
    allow_nil: true,
    allow_blank: true
  validates :number,
    format: {with: /\d/},
    length: { maximum: 16 },
    allow_nil: true,
    allow_blank: true
  validates :words, :about,
    length: { maximum: 1000 },
    allow_nil: true,
    allow_blank: true

  private

  def at_least_one_day_old
    # errors.add(:birthday, "Have to be older than 1 day old.") if self.birthday == Date.today - 1
    true
  end
end
