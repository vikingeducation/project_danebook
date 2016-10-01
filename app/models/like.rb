class Like < ApplicationRecord
  belongs_to :initiated_user, class_name: "User", foreign_key: :user_id
  belongs_to :post

  def initiated_user_name
    self.initiated_user.name
  end

end
