class Like < ActiveRecord::Base

  validates :user, :liking_id, :liking_type, presence: :true
  belongs_to :user
  belongs_to :liking, polymorphic: true



end
