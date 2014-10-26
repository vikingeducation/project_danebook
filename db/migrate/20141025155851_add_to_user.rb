class AddToUser < ActiveRecord::Migration
  def change
    add_column :users, :words, :text
    add_column :users, :about, :text
    add_column :users, :phone, :string
  end
end
