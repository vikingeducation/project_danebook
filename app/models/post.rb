class Post < ActiveRecord::Base

  belongs_to :user
  has_many :likes, as: :likings, class_name: "Likes"

  validates :body, :presence => :true

end
