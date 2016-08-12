class ChangeBdayForProfile < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :bday_month
    remove_column :profiles, :bday_day
    remove_column :profiles, :bday_year
    add_column :profiles, :birthday, :date
  end
end
