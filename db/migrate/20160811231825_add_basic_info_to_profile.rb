class AddBasicInfoToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :college, :string, default: ""
    add_column :users, :hometown_id, :integer
    add_column :users, :curr_addr_id, :integer
  end
end
