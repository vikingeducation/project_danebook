class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
  belongs_to :city
  belongs_to :state
  belongs_to :country
end
