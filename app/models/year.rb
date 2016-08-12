class Year < ApplicationRecord

  def self.all_years
    order('year DESC')
  end

end
