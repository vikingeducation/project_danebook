class Timeline < ActiveRecord::Base
  has_one :user, dependent: :nullify
  has_one :profile, through: :user
  has_many :posts, through: :user
  has_many :comments, through: :posts
  has_many :friends, through: :user
end
