class Friending < ActiveRecord::Base
  belongs_to :friender, :class_name => "User", :foreign_key => :friender_id

  belongs_to :friended, :class_name => "User", :foreign_key => :friended_id
end
