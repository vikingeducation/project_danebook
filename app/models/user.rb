class User < ApplicationRecord
  belongs_to :profile_pic, class_name: "Photo"
  belongs_to :cover_pic, class_name: "Photo"

  has_many :comments, dependent: :nullify
end
