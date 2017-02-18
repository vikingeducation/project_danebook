class Like < ApplicationRecord
  belongs_to :likable_thing, polymorphic: true
  belongs_to :liker, class_name: "User"
end
