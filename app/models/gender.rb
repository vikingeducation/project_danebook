class Gender < ActiveRecord::Base
  has_many :users, :dependent => :nullify
end
