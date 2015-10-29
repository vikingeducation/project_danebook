class SeparateBirthdateIntoParts < ActiveRecord::Migration
  def change
    remove_column :profiles, :birthdate
    add_column :profiles, :birth_month, :integer, :null => false
    add_column :profiles, :birth_day, :integer, :null => false
    add_column :profiles, :birth_year, :integer, :null => false
  end

  add_index :profiles, :user_id, :unique => true
end
