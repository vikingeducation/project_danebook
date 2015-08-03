class User < ActiveRecord::Base

  has_secure_password

  validates :email, :presence => true,
                    :format => { :with => /@/ }

  validates :password, :presence => true,
                        :length => {:in => 8..25},
                        :on => :create, :update,
                        :allow_nil => true

  validates :first_name, :last_name, :presence => true,
                                    :length => {:in => 5..30}


end
