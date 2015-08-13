class Comment < ActiveRecord::Base

  #=================== associations =========================

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  has_many :likes, as: :likings, class_name: "Like", dependent: :destroy

  #=================== validations =========================

  validates :commentable_id, :commentable_type, :body, :user_id,
            :presence => :true

  validates :body, :format => {:with => /[a-zA-Z]+/}

end
