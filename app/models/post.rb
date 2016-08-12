class Post < ActiveRecord::Base
  after_create :defaults
  
  belongs_to :user, inverse_of: :posts
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  accepts_nested_attributes_for :likes

  private
    def defaults
    end
end
