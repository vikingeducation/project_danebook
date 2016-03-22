class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile
  
  validates :birthday, :gender, presence: true,
            :allow_nil => true
  validates :user, presence: true
end
