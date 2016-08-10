class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
  has_one :city
  has_one :state
  has_one :country
end
