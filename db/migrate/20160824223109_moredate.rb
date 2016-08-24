class Moredate < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :home, :string
    add_column :users, :lives, :string
    add_column :users, :phone, :string
    add_column :users, :college, :string
    add_column :users, :words, :text
    add_column :users, :bio, :text

  end
end
