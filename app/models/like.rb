class Like < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :author_id
  belongs_to :likeable, polymorphic: true

  validates :likeable, presence: true
  validates :author, presence: true
end
