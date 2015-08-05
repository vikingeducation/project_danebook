class Like < ActiveRecord::Base
  belongs_to :post
  belongs_to :comment
  belongs_to :user

  belongs_to :likeable, polymorphic: true

  def self.include_user?(current_user)
    self.where("user_id = ?", current_user.id).length < 1
  end
end
