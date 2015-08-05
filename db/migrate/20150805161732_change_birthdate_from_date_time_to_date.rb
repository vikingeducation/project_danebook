class ChangeBirthdateFromDateTimeToDate < ActiveRecord::Migration
  def change
    change_column :profiles, :birthdate, :date, :null => false
  end
end
