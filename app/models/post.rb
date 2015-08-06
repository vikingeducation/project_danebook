class Post < ActiveRecord::Base
  has_many :likes, :as => :likeable
  belongs_to :user
end
