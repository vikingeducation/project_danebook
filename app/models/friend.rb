class Friend < ApplicationRecord
  belongs_to :friender, foreign_key: :friender_id, class_name: "User"
  belongs_to :friendee, foreign_key: :friendee_id, class_name: "User"

 validates :friendee_id, :uniqueness => { :scope => :friender_id }
end
