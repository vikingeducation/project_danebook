class AddDaysToProfileDates < ActiveRecord::Migration
  def change
    add_column :profile_dates, :day, :integer, default: 1
  end
end
