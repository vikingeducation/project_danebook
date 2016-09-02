class User < ApplicationRecord
  before_create :generate_token
  
end
