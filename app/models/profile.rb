class Profile < ApplicationRecord

  belongs_to :user, optional: true

  def birthday
    "#{month}\/#{day}\/#{year}"
  end

  def birthday= (datestring)
    date = datestring.split('\/')
    self.month = date[0]
    self.day = date[1]
    self.year = date[2]
  end

end
