class Post < ActiveRecord::Base
  belongs_to :author, :class_name => "User", :foreign_key => :user_id
  belongs_to :receiver, :class_name => "User", :foreign_key => :receiver_id
  has_many :likes
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments
end
