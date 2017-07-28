class User < ApplicationRecord

  has_one :profile, inverse_of: :user,
                    autosave: true,
                    :dependent => :destroy

  has_many  :posts,
            :dependent => :destroy

  has_many :comments
  has_many :likes

  has_many :initiated_friendings, :class_name => 'Friending',
                                  :foreign_key => :friender_id

  has_many :friended_users, :through => :initiated_friendings,
                            :source => :friend_recipent

  has_many :users_who_initiated, :through => :accepted_friendings,
                                  :source => :friend_initiator

  has_many :accepted_friendings,  :class_name => 'Friending',
                                  :foreign_key => :friend_id



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
