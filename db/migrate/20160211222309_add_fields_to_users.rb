class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, presence: true
    add_column :users, :last_name, :string, presence: true
    add_column :users, :birthday, :datetime
    add_column :users, :gender, :string, inclusion: { in: ["Male", "Female"] }

  end
end
