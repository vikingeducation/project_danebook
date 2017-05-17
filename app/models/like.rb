class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likable, polymorphic: true
  validates_presence_of :user, :likable
end
