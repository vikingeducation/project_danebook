class DropProfileDates < ActiveRecord::Migration
  def change
    drop_table :profile_dates
    add_column :birthdays, :date_object, :date
  end
end
