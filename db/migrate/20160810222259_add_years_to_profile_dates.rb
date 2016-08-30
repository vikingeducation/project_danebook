class AddYearsToProfileDates < ActiveRecord::Migration
  def change
    add_column :profile_dates, :year, :integer, default: 1987
  end
end
