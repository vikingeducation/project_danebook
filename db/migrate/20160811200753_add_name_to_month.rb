class AddNameToMonth < ActiveRecord::Migration[5.0]
  def change
    add_column :months, :month_name, :string
  end
end
