class Like < ApplicationRecord

  belongs_to :likable, polymorphic: true, touch: true
  belongs_to :user

end
