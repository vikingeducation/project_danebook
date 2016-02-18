class Friending < ActiveRecord::Base
  belongs_to :friender, class_name: "User"
  belongs_to :friended, class_name: "User"

  validates :friender, presence: true
  validates :friended, presence: true
  validates :friender_id, :uniqueness => { :scope => :friended_id, message: "can't friend the same user twice!"}
end
