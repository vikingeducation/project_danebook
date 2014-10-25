class Like < ActiveRecord::Base
  belongs_to :likable, polymorphic: true

  # make sure that the user and liked item are real
  validates :user, :likable, presence: true
  # make sure that likes are only possible for appropriate objects
  validates :likable_type, inclusion: ["post", "comment"]
  # a user can only like a thing once
  validates :user, uniqueness: true, scope: :likable
end
