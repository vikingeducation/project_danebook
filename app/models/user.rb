class User < ApplicationRecord

  has_one :profile, inverse_of: :user, 
                    autosave: true,
                    :dependent => :destroy

  accepts_nested_attributes_for :profile,
                                :allow_destroy => true
                                # :reject_if => :all_blank,

  has_secure_password

  validates :password,
            :length => { :in => 4..16},
            :allow_nil => true

  validates   :email,
              :format => { :with => /@/ },
              :uniqueness => true

  before_create :generate_token



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



end
