class Location < ActiveRecord::Base
  has_many :users

  def self.get_location(id)
    Location.find(id)
  end

  def to_s
    "#{self.city}, #{self.country}"
  end
end
