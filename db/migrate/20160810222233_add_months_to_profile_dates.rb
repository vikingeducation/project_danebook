class AddMonthsToProfileDates < ActiveRecord::Migration
  def change
    add_column :profile_dates, :month, :integer, default: 1
  end
end
