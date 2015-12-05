class Profile < ActiveRecord::Base
  include Dateable
  
  belongs_to :user
end
