class Likpoly < ActiveRecord::Migration[5.0]
  def change
    add_column :likes, :likable_type, :string

  end
end
