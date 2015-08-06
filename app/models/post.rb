class Post < ActiveRecord::Base

  belongs_to :author, :class_name => 'User', :foreign_key => :author_id

  validates :body, :author_id, :presence => :true
  validates :body, :length => { in: 1..255 }
end
