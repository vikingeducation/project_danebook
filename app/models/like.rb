class Like < ActiveRecord::Base
  belongs_to :likable
  belongs_to :user
end
