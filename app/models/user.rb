class User < ApplicationRecord

  has_one :profile, inverse_of: :user, autosave: true

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


end
