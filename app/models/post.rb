class Post < ActiveRecord::Base
  # has_many :feeds
  # has_many :users, through: :feeds
  belongs_to :user

  validates :description, :length => {in: 1..400}
end
