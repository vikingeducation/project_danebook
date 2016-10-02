class Like < ApplicationRecord
  belongs_to :initiated_user, class_name: "User", foreign_key: :user_id

  belongs_to :likable, polymorphic: true, counter_cache: true


  def initiated_user_name
    self.initiated_user.name
  end

end
