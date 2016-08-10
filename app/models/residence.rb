class Residence < ActiveRecord::Base
  belongs_to :profile
  has_one :address, as: :addressable
end
