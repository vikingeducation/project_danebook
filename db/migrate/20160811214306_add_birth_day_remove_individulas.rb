class AddBirthDayRemoveIndividulas < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :birth_day_id
    remove_column :users, :birth_month_id
    remove_column :users, :birth_year_id
    add_column :users, :birthday, :datetime
  end
end
