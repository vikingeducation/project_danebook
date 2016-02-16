class Like < ActiveRecord::Base
  belongs_to :likeable, polymorphic: true

  belongs_to :liked_by, class_name: "User", foreign_key: :user_id

end
