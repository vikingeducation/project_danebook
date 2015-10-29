class ReturningToUseBirthdate < ActiveRecord::Migration
  def change
    remove_column :profiles, :birth_month
    remove_column :profiles, :birth_day
    remove_column :profiles, :birth_year
    add_column :profiles, :birthdate, :datetime, :null => false
  end
end
