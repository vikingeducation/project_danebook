class Like < ActiveRecord::Base
  belongs_to :likeable, polymorphic: true
  belongs_to :user

  validates :user, presence: true
  validates :likeable, presence: true

  validates :user_id, uniqueness: { scope: [:likeable_id, :likeable_type], message: "has already like this thing!" }
end
