class Post < ActiveRecord::Base

  #=================== associations =========================

  belongs_to :user

  has_many :likes, as: :likings, class_name: "Like",
            dependent: :destroy

  has_many :comments, as: :commentable, class_name: "Comment",
            dependent: :destroy

  #=================== validations =========================

  validates :body, :user_id, :presence => :true

  validates :body, :format => {:with => /[a-zA-Z]+/}


end
