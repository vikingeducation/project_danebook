class User < ActiveRecord::Base

	has_one :profile, :dependent => :destroy
	has_secure_password
	
	validates :password, 
						:presence => true,
						:length => {:in => 4..24}
	validates :email, 
						:format => {:with => /@/}, 
						:uniqueness => true
 	# validates :username, 
 	# 					:presence => {:message => "required"}

 	after_create :create_profile

 	private


end
