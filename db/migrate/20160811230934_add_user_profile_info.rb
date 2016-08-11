class AddUserProfileInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :telephone, :string, default: ""
    add_column :users, :quote, :string, default: ""
    add_column :users, :about, :text, default: ""
  end
end
