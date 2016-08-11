class ChangeNameOfBirthCols < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :birth_day, :birth_day_id
    rename_column :users, :birth_month, :birth_month_id
    rename_column :users, :birth_year, :birth_year_id
  end
end
