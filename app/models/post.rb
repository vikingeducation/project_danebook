class Post < ActiveRecord::Base

  belongs_to :user
  has_many :likes, as: :likings, class_name: "Like"

  validates :body, :presence => :true

  def you_liked?

  end

end
