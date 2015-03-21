class Like < ActiveRecord::Base
  belongs_to :likable, polymorphic: true

  #aliased this two ways to avoid breaking previous associations
  belongs_to :user
  belongs_to :liker, class_name: "User"

  validates_uniqueness_of :user_id, scope: [:likable_id, :likable_type]
  validates_presence_of :user_id, :likable_id, :likable_type

  LIKABLES = [:posts, :comments, :photos]
end
