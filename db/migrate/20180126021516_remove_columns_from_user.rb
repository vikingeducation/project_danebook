class RemoveColumnsFromUser < ActiveRecord::Migration[5.0]
  def up
    remove_column :users, :cover_pic
    remove_column :users, :headshot_pic
  end

  def down
    add_column :users, :cover_pic, :string, null: false, default: ''
    add_column :users, :headshot_pic, :string, null: false, default: ''
  end
end
