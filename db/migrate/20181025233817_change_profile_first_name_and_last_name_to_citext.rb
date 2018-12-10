class ChangeProfileFirstNameAndLastNameToCitext < ActiveRecord::Migration[5.0]
  def change
    enable_extension :citext
    change_column :profiles, :first_name, :citext
    change_column :profiles, :last_name, :citext
    add_index :profiles, :first_name
    add_index :profiles, :last_name
  end
end
