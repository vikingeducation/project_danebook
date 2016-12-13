class Like < ApplicationRecord

  belongs_to :likeable, polymorphic: true

  belongs_to :user, foreign_key: :liker_id
  
end
