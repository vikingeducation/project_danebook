class Post < ActiveRecord::Base
  belongs_to :user

  has_many :likes, as: :likable, dependent: :destroy

  validates :content, presence: true,
                        length: { maximum: 140 } # Twitter!
end
