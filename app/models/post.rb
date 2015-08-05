class Post < ActiveRecord::Base
  # has_many :users, :through => :user_postings
  # has_many :user_postings
  belongs_to :user
  has_many :likes, as: :likeable
  has_many :post_likings

  has_many :comments, :as => :commentable


  #like model has similar helpermethod
  # def likes_include_current_user?
  #   self.likes.where("user_id = ?", current_user.id).length < 1
  # end
end
