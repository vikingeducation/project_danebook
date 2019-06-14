class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :birthday, :date
    add_column :users, :hometown, :string, null: false, default: ""
    add_column :users, :current_town, :string, null: false, default: ""
    add_column :users, :college, :string, null: false, default: ""
    add_column :users, :phone, :string, null: false, default: ""
    add_column :users, :quote, :text, null: false, default: ""
    add_column :users, :bio, :text, null: false, default: ""
    add_column :users, :headshot_pic, :string, null: false, default: ""
    add_column :users, :cover_pic, :string, null: false, default: ""
  end
end
