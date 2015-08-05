class Profile < ActiveRecord::Base
  belongs_to :user

  def birthday
    "#{birthday_month}/#{birthday_day}/#{birthday_year}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
