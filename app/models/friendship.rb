class Friendship < ApplicationRecord
  belongs_to :friender, class_name: "User", foreign_key: :friender_id
  belongs_to :friended, class_name: "User", foreign_key: :friended_id

  validates :friended_id, :uniqueness => { :scope => :friender_id }
end
