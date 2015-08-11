class Friending < ActiveRecord::Base
  belongs_to :user
  belongs_to friend, class_name: "User"

  validates :user_id, uniqueness: {scope: :friend_id}
  validates :user, presence: true
  validates :friend, presence: true
end
