class Comment < ActiveRecord::Base

  belongs_to :post
  has_many :likes, as: :likeable


  validates :body, length: { in: 1..250 }


end
