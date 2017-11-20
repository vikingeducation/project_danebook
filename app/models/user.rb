class User < ApplicationRecord
  before_create :generate_token

  has_one :profile, inverse_of: :user,
                    :dependent => :destroy

  accepts_nested_attributes_for :profile,
                                reject_if: :all_blank,
                                :allow_destroy => true

  has_secure_password
  
  validates :password, 
            :length => { :in => 3..24 }, 
            :allow_nil => true


  has_many :posts

  has_many :likes,
           :dependent => :destroy
           
  
  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  # Convenience method for generating the token by first clearing it
  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end
end
