class ProfileDate < ActiveRecord::Base
  after_create :defaults

  belongs_to :dateable, polymorphic: true

  private
    def defaults
      self.day = 1
      self.month = 1
      self.year = 1987
      save!
    end
end
