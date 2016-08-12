class Activity < ApplicationRecord

  belongs_to :postable, :polymorphic => true, dependent: :destroy
  belongs_to :author, class_name: "User"
  has_many :likes, :as => :likeable, class_name: "Liking"
  has_many :likers, through: :likes, source: :user

end
