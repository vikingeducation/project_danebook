class AddSomethingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :something, :string
  end
end
