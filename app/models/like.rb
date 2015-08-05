class Like < ActiveRecord::Base
  belongs_to :user
  has_many :post_likings
  has_many :posts, through: :post_likings

  def self.include_user?(user)
    self.where("user_id = ?", user.id).length < 1
  end
end
