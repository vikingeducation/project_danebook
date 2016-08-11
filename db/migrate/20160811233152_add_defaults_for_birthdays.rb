class AddDefaultsForBirthdays < ActiveRecord::Migration
  def change
    change_column :birthdays, :date_object, :date, default: 30.years.ago.to_date
  end
end
