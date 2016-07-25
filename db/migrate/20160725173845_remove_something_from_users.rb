class RemoveSomethingFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :something, :string
  end
end
