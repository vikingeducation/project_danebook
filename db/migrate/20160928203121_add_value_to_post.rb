class AddValueToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :profile_id, :integer
  end
end
