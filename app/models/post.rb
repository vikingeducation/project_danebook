class Post < ActiveRecord::Base

  belongs_to :user, :foreign_key => :author_id

  validates :body, :author_id, :presence => :true
  validates :body, :length => { in: 1..255 }
end
