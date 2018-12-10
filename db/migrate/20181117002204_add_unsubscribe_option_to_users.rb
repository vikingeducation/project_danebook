class AddUnsubscribeOptionToUsers < ActiveRecord::Migration[5.0]

  def up
    add_column :users, :unsubscribe, :boolean, default: false
  end

  def down
    remove_column :users, :unsubscribe
  end

end
