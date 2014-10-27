class Profile < ActiveRecord::Base
	belongs_to :user # foreign key is user_id
end
