class User < ActiveRecord::Base
    
    before_create :generate_token
    has_secure_password
    #before_save :create_profile
    
    validates :password,
              :length => { :in => 6..10 },
              :presence => true
    
    has_one :profile, dependent: :destroy
    accepts_nested_attributes_for :profile

private
    def generate_token
       begin
        self[:auth_token] = SecureRandom.urlsafe_base64
       end while User.exists?(:auth_token => self[:auth_token])
    end
    
    def regenerate_auth_token
        self.auth_token = nil
        generate_token
        save!
    end
    
    def create_profile
       p = Profile.new
       p.user_id = self.id
       p.save 
    end
end
