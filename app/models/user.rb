class User < ActiveRecord::Base

	has_one 	:profile, :dependent => :destroy
	has_many 	:posts
	# likes are polymorphic
	has_many 	:likes
	has_many 	:posts_liked_by_users, through: :likes, source: :post 

	has_many :comments

	has_secure_password
	
	validates :password, 
						:presence => true,
						:length => {:in => 4..24}
	validates :email, 
						:format => {:with => /@/}, 
						:uniqueness => true
 	validates :first_name, :last_name, :presence => true

 	after_create :create_profile

private

end
