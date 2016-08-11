class Address < ActiveRecord::Base
  before_save :default_address

  belongs_to :addressable, polymorphic: true
  belongs_to :city
  belongs_to :state
  belongs_to :country

  private
    def default_address
      self.city = City.first
      self.state = State.first
      self.country = Country.first
    end

end
