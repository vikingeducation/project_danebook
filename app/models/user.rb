class User < ActiveRecord::Base

	has_secure_password
	
	validates :password, 
						:presence => true,
						:length => {:in => 4..24}
	validates :email, 
						:format => {:with => /@/}, 
						:uniqueness => true
 	# validates :username, 
 	# 					:presence => {:message => "required"}

end
