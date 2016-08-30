class Residence < ActiveRecord::Base
  belongs_to :profile
  has_one :address, as: :addressable

  accepts_nested_attributes_for :address
end
