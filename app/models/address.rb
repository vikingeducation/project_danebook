class Address < ActiveRecord::Base
  after_create :default_address

  belongs_to :addressable, polymorphic: true
  belongs_to :city
  belongs_to :state
  belongs_to :country

  [:city, :state, :country].each do |e|
    accepts_nested_attributes_for e
  end

  private
    def default_address
      self.city = City.first
      self.state = State.first
      self.country = Country.first
      save!
    end

end
