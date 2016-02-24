class Addattachphotos < ActiveRecord::Migration
  def change
    add_attachment :photos, :image
    add_column :photos, :user_id, :integer
  end
end
