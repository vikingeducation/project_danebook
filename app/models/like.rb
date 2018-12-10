class Like < ApplicationRecord

  belongs_to :user
  belongs_to :likable, polymorphic: true, touch: true

end
